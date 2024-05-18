part of 'filter_cubit.dart';

class FilterState extends Equatable {
  final String? brand;
  final SortCriteria? sortCriteria;
  final String? gender;
  final String? color;
  final double minPrice;
  final double maxPrice;

  const FilterState({
    this.brand,
    this.sortCriteria,
    this.gender,
    this.color,
    this.minPrice = 0.0,
    this.maxPrice = 1000,
  });

  FilterState copyWith({
    String? brand,
    SortCriteria? sortCriteria,
    String? gender,
    String? color,
    double? minPrice,
    double? maxPrice,
  }) {
    return FilterState(
      brand: brand ?? this.brand,
      sortCriteria: sortCriteria ?? this.sortCriteria,
      gender: gender ?? this.gender,
      color: color ?? this.color,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }

  @override
  List<Object?> get props => [brand, sortCriteria, gender, color, minPrice, maxPrice];
}
