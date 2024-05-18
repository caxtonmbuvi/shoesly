import 'package:equatable/equatable.dart';

import '../../../exports.dart';
import '../models/brands_model.dart';
import '../repo/brand_repo.dart';

part 'brand_state.dart';

class BrandCubit extends Cubit<BrandState> {
  final BrandRepository _brandRepository;

  BrandCubit(this._brandRepository) : super(BrandInitial());

  void fetchBrands() async {
    try {
      final brands = await _brandRepository.fetchBrands();
      final allBrands = [Brand(id: 'all', name: 'All', imageUrl: '')] + brands;
      final brandCounts = await _brandRepository.fetchBrandProductCounts();
      emit(BrandLoaded(brands: allBrands, brandCounts: brandCounts));
    } catch (e) {
      emit(BrandError(message: e.toString()));
    }
  }

  Future<void> addBrandsToFirebase() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference brandsCollection = firestore.collection('brands');

    List<Map<String, dynamic>> brands = [
      {"name": "Nike"},
      {"name": "Adidas"},
      {"name": "Puma"},
      {"name": "Reebok"},
      {"name": "New Balance"},
      {"name": "Asics"},
      {"name": "Under Armour"},
      {"name": "Skechers"},
      {"name": "Converse"},
      {"name": "Vans"},
      {"name": "FILA"},
      {"name": "Brooks"},
      {"name": "Salomon"},
      {"name": "Merrell"},
      {"name": "Saucony"},
      // Add more brands as needed
    ];

    for (var brand in brands) {
      await brandsCollection.add(brand);
    }

    print("Brand data saved successfully to Firestore");
  }
}
