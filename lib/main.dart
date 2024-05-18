import 'exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final ProductRepository productRepository = ProductRepository();
  final BrandRepository brandRepository = BrandRepository();
  final ReviewRepository reviewRepository = ReviewRepository();
  final PaymentRepository paymentRepository = PaymentRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FilterCubit(),
        ),
        BlocProvider(
          create: (context) => ProductCubit(
            productRepository,
            context.read<FilterCubit>(),
          ),
        ),
        BlocProvider(
          create: (context) => BrandCubit(brandRepository),
        ),
        BlocProvider(
          create: (context) => CartCubit(),
        ),
        BlocProvider(
          create: (context) => ReviewsCubit(reviewRepository),
        ),
        BlocProvider(
          create: (context) => PaymentCubit(paymentRepository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Locator',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routes: AppRoutes.routes,
          initialRoute: Routes.homeScreen,
        );
      },
    );
  }
}
