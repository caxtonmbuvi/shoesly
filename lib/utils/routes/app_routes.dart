

import 'package:shoesly/exports.dart';
import 'package:shoesly/features/home/ui/home_screen.dart';

class AppRoutes {
  static final routes = {
    Routes.homeScreen: (context) =>  const HomeScreen(),
    Routes.cart: (context) => const Cart(),
    Routes.orderSummary: (context) => const OrderSummary(),
    Routes.orderHistory: (context) => const OrderHistory(),
    
  };
}
