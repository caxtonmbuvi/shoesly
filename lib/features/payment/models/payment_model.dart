import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Payment {
  final String id;
  final String userId;
  final String location;
  final String paymentMethod;
  final List<Map<String, dynamic>> orderDetails;
  final double totalPayment;
  final DateTime timestamp;

  Payment({
    required this.id,
    required this.userId,
    required this.location,
    required this.paymentMethod,
    required this.orderDetails,
    required this.totalPayment,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'location': location,
      'paymentMethod': paymentMethod,
      'orderDetails': orderDetails,
      'totalPayment': totalPayment,
      'timestamp': timestamp,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'],
      userId: map['userId'],
      location: map['location'],
      paymentMethod: map['paymentMethod'],
      orderDetails: List<Map<String, dynamic>>.from(map['orderDetails']),
      totalPayment: map['totalPayment'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }
}

class OrderDetail {
  final String productId;
  final int quantity;
  final double price;

  OrderDetail({
    required this.productId,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'quantity': quantity,
      'price': price,
    };
  }

  factory OrderDetail.fromMap(Map<String, dynamic> map) {
    return OrderDetail(
      productId: map['productId'],
      quantity: map['quantity'],
      price: map['price'],
    );
  }
}


Map<String, List<Payment>> groupPaymentsByDate(List<Payment> payments) {
  Map<String, List<Payment>> groupedPayments = {};

  for (var payment in payments) {
    String date = DateFormat.yMMMMd().format(payment.timestamp.toLocal()); // Format date
 // Extract date part

    if (groupedPayments[date] == null) {
      groupedPayments[date] = [];
    }

    groupedPayments[date]!.add(payment);
  }

  return groupedPayments;
}