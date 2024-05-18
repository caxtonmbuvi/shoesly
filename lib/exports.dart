export 'package:cloud_firestore/cloud_firestore.dart';
export 'package:flutter/gestures.dart';
export 'package:flutter/material.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:flutter_rating_bar/flutter_rating_bar.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'package:equatable/equatable.dart';

//Utilities
export 'gen/colors.gen.dart';
export 'gen/fonts.gen.dart';
export 'utils/widgets/app_text.dart';
export 'gen/assets.gen.dart';
export 'utils/widgets/custom_bottom_bar.dart';
export 'utils/api/firebase_api.dart';
export 'utils/routes/app_routes.dart';
export 'utils/routes/routes.dart';

//cart
export 'features/cart/ui/cart.dart';
export 'features/cart/ui/order_summary.dart';
export 'features/cart/cubit/cart_cubit.dart';
export 'features/cart/ui/widgets/information_card.dart';
export 'features/cart/ui/widgets/payment_detail.dart';
export 'features/cart/ui/success_payment.dart';

//Home
export 'features/home/models/product_model.dart';
export 'package:shoesly/features/home/ui/filter.dart';
export 'features/home/cubit/brand_cubit.dart';
export 'features/home/models/brands_model.dart';
export 'features/home/cubit/filter_cubit.dart';
export 'features/home/cubit/products_cubit.dart';
export 'features/home/repo/brand_repo.dart';
export 'features/home/repo/product_repo.dart';
export 'features/home/ui/widgets/brand_filter.dart';

// Reviews
export 'features/review/cubit/reviews_cubit.dart';
export 'features/review/ui/reviews.dart';
export 'features/review/ui/widgets/review_item.dart';
export 'features/review/repository/review_repo.dart';
export 'features/review/models/review_model.dart';

// Product
export 'features/product/ui/product_detail.dart';
export 'features/product/ui/widgets/add_success_pop.dart';
export 'features/product/ui/widgets/add_cart_pop.dart';
export 'features/product/ui/widgets/imageview.dart';

// Payment
export 'features/payment/cubit/payment_cubit.dart';
export 'features/payment/repo/payment_repo.dart';
export 'features/payment/cubit/payment_state.dart';
export 'features/payment/models/payment_model.dart';

//Order History
export 'features/payment/ui/order_history.dart';



