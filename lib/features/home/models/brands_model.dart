import '../../../exports.dart';

class Brand {
  final String id;
  final String name;
  final String imageUrl;

  Brand({required this.id, required this.name, required this.imageUrl});

  factory Brand.fromDocument(DocumentSnapshot doc) {
    return Brand(
      id: doc.id,
      name: doc['name'],
      imageUrl: doc['image_url'],
    );
  }
}
