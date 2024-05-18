// part of 'products_cubit.dart';

// @immutable
// abstract class ProductState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class ProductInitial extends ProductState {}

// class ProductLoading extends ProductState {
//   final List<Product> oldProducts;
//   final bool isFirstFetch;

//   ProductLoading(this.oldProducts, {this.isFirstFetch = false});

//   @override
//   List<Object?> get props => [oldProducts, isFirstFetch];
// }

// class ProductLoaded extends ProductState {
//   final List<Product> products;
//   final DocumentSnapshot? lastDocument;

//   ProductLoaded(this.products, this.lastDocument);

//   @override
//   List<Object?> get props => [products, lastDocument];
// }


// class ProductError extends ProductState {
//   final String message;

//   ProductError(this.message);

//   @override
//   List<Object?> get props => [message];
// }
part of 'products_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {
  final List<Product> oldProducts;
  final bool isFirstFetch;

  const ProductLoading(this.oldProducts, {this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldProducts, isFirstFetch];
}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final DocumentSnapshot? lastDocument;
  final String? selectedBrand;

  const ProductLoaded(this.products, this.lastDocument, {this.selectedBrand});

  @override
  List<Object?> get props => [products, lastDocument, selectedBrand];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
