part of 'cart_cubit.dart';

class CartState extends Equatable {
  final Map<Product, int> items;

  CartState({Map<Product, int>? items}) : items = items ?? {};

  CartState copyWith({Map<Product, int>? items}) {
    return CartState(items: items ?? this.items);
  }

  @override
  List<Object?> get props => [items];
}
