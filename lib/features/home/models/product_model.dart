// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:shoesly/exports.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String brandId;
  final List<String> colors;
  final String description;
  final String rating;
  final String reviews;
  final List<String> sizes;
  final List<String> images;
  final DateTime date;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.brandId,
    required this.colors,
    required this.description,
    required this.rating,
    required this.reviews,
    required this.sizes,
    required this.images,
    required this.date
  });

  factory Product.fromDocument(DocumentSnapshot doc) {
    return Product(
      id: doc.id,
      name: doc['name'],
      price: doc['price'].toDouble(),
      brandId: doc['brandId'],
      colors: List<String>.from(doc['colors'] ?? []),
      description: doc['description'],
      rating: doc['rating'].toString(),
      reviews: doc['reviews'].toString(),
      sizes: List<String>.from(doc['sizes'] ?? []),
      images: List<String>.from(doc['images'] ?? []),
      date: (doc['createdAt'] as Timestamp).toDate(),
    );
  }

  // factory Product.fromJson(Map<String, dynamic> json) {
  //   return Product(
  //     id: json['id'],
  //     name: json['name'],
  //     images: List<String>.from(json['images']),
  //     price: json['price'],
  //     brandId: json['brandId'],
  //     colors: List<String>.from(json['colors']),
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'imageUrl': imageUrl,
  //     'price': price,
  //     'brandId': brandId,
  //     'colors': colors,
  //   };
  // }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'brandId': brandId,
      'colors': colors,
      'description': description,
      'rating': rating,
      'reviews': reviews,
      'sizes': sizes,
      'images': images,
      'createdAt': date.toIso8601String(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      brandId: map['brandId'],
      colors: List<String>.from(map['colors']),
      description: map['description'],
      rating: map['rating'],
      reviews: map['reviews'],
      sizes: List<String>.from(map['sizes']),
      images: List<String>.from(map['images']),
      date: DateTime.parse(map['createdAt'])
    );
  }

 
}
