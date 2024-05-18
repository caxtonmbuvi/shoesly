import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'filter_state.dart';

enum SortCriteria { mostRecent, lowestPrice, highestReviews }

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterState());

  void updateBrand(String? brand) {
    emit(state.copyWith(brand: brand));
  }

  void updateSortCriteria(SortCriteria? sortCriteria) {
    emit(state.copyWith(sortCriteria: sortCriteria));
  }

  void updateGender(String? gender) {
    emit(state.copyWith(gender: gender));
  }

  void updateColor(String? color) {
    emit(state.copyWith(color: color));
  }

  void updatePriceRange(double minPrice, double maxPrice) {
    emit(state.copyWith(minPrice: minPrice, maxPrice: maxPrice));
  }

  void resetFilters() {
    emit(const FilterState());
  }


  int activeFiltersCount() {
    int count = 0;
    if (state.brand != null) count++;
    if (state.sortCriteria != null) count++;
    if (state.gender != null) count++;
    if (state.color != null) count++;
    if (state.minPrice != 0 || state.maxPrice != 1000) count++;
    return count;
  }
}

