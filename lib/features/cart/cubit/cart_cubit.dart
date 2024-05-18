import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../home/models/product_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState()) {
    _loadCart();
  }

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cart');
    if (cartData != null) {
      final Map<String, dynamic> cartMap = json.decode(cartData);
      final items = cartMap.map((key, value) {
        final product = Product.fromMap(json.decode(key));
        final quantity = value as int;
        return MapEntry(product, quantity);
      });
      emit(state.copyWith(items: items));
    }
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartMap = state.items.map((key, value) {
      final productJson = json.encode(key.toMap());
      return MapEntry(productJson, value);
    });
    final cartData = json.encode(cartMap);
    await prefs.setString('cart', cartData);
  }

  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cart');
    emit(state.copyWith(items: {}));
  }

  void addToCart(Product product, int quantity) {
    if (quantity >= 1) {
      final items = Map.of(state.items);
      items.update(product, (existingQuantity) => existingQuantity + quantity,
          ifAbsent: () => quantity);
      emit(state.copyWith(items: items));
      _saveCart();
    }
  }

  void updateQuantity(Product product, int quantity) {
    if (quantity >= 1) {
      final items = Map.of(state.items);
      items.update(product, (_) => quantity, ifAbsent: () => quantity);
      emit(state.copyWith(items: items));
      _saveCart();
    }
  }

  void incrementQuantity(Product product) {
    final currentQuantity = state.items[product] ?? 1;
    updateQuantity(product, currentQuantity + 1);
  }

  void decrementQuantity(Product product) {
    final currentQuantity = state.items[product] ?? 1;
    if (currentQuantity > 1) {
      updateQuantity(product, currentQuantity - 1);
    }
  }

  void removeFromCart(Product product) {
    final items = Map.of(state.items);
    items.remove(product);
    emit(state.copyWith(items: items));
    _saveCart();
  }

  List<Map<String, dynamic>> convertOrderDetails(Map<Product, int> items) {
    return items.entries.map((entry) {
      final product = entry.key;
      final quantity = entry.value;
      return {
        'productImage': product.images.first,
        'productId': product.id,
        'productName': product.name,
        'quantity': quantity,
        'price': product.price,
        'total': product.price * quantity,
      };
    }).toList();
  }

  double get totalPrice => state.items.entries
      .map((entry) => entry.key.price * entry.value)
      .fold(0.0, (total, current) => total + current);

  double get totalOrder =>
      state.items.entries
          .map((entry) => entry.key.price * entry.value)
          .fold(0.0, (total, current) => total + current) +
      20.00;
}
