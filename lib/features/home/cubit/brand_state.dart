part of 'brand_cubit.dart';

class BrandState extends Equatable {
  @override
  List<Object> get props => [];
}

class BrandInitial extends BrandState {}

class BrandLoading extends BrandState {}

class BrandLoaded extends BrandState {
  final List<Brand> brands;
  final Map<String, int> brandCounts;

  BrandLoaded({required this.brands, required this.brandCounts});

  @override
  List<Object> get props => [brands, brandCounts];
}

class BrandError extends BrandState {
  final String message;

  BrandError({required this.message});

  @override
  List<Object> get props => [message];
}
