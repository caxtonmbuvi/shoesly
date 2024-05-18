import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoesly/features/home/repo/product_repo.dart';
import '../models/product_model.dart';
import 'filter_cubit.dart';

part 'products_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _productRepository;
  final FilterCubit _filterCubit;

  ProductCubit(this._productRepository, this._filterCubit)
      : super(ProductInitial());

  void fetchProducts({DocumentSnapshot? lastDocument}) async {
    if (state is ProductLoading) return;

    final currentState = state;
    var oldProducts = <Product>[];
    if (currentState is ProductLoaded && lastDocument != null) {
      oldProducts = currentState.products;
    }

    final filterState = _filterCubit.state;

    try {
      emit(ProductLoading(oldProducts, isFirstFetch: lastDocument == null));
      final data = await _productRepository.fetchProducts(
        lastDocument: lastDocument,
        brandId: filterState.brand == 'all' ? null : filterState.brand,
        gender: filterState.gender,
        color: filterState.color,
        sortCriteria: filterState.sortCriteria,
        minPrice: filterState.minPrice,
        maxPrice: filterState.maxPrice,
      );
      print("Error: $data");
      final newProducts = data['products'] as List<Product>;
      var products =
          lastDocument == null ? newProducts : oldProducts + newProducts;

      // Sort the entire list if sort criteria is provided
      if (filterState.sortCriteria != null) {
        switch (filterState.sortCriteria) {
          case SortCriteria.lowestPrice:
            products.sort((a, b) => a.price.compareTo(b.price));
            break;
          case SortCriteria.highestReviews:
            products.sort((a, b) => b.reviews.compareTo(a.reviews));
            break;
          case SortCriteria.mostRecent:
          default:
            products.sort((a, b) => b.date.compareTo(a.date));
            break;
        }
      }

      emit(ProductLoaded(products, data['lastDocument']));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void applyFilters() {
    fetchProducts();
  }
}
