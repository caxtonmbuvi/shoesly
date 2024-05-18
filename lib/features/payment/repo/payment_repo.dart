import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoesly/features/payment/models/payment_model.dart';

class PaymentRepository {
  final FirebaseFirestore _firestore;
  PaymentRepository() : _firestore = FirebaseFirestore.instance;

  Future<void> addPayment(Payment payment) async {
    await _firestore.collection('payments').doc(payment.id).set(payment.toMap());
  }

  Future<List<Payment>> getPaymentHistory(String userId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('payments')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => Payment.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
