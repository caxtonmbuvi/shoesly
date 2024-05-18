import 'package:shoesly/features/payment/models/payment_model.dart';
import 'package:shoesly/features/payment/repo/payment_repo.dart';

import '../../../exports.dart';
import 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepository _paymentRepository;

  PaymentCubit(this._paymentRepository)
      : super(PaymentInitial());

  Future<void> addPayment(Payment payment) async {
    try {
      emit(PaymentLoading());
      await _paymentRepository.addPayment(payment);
      emit(PaymentAdded());
      
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }

  Future<void> fetchPaymentHistory(String userId) async {
    try {
      emit(PaymentLoading());
      final payments = await _paymentRepository.getPaymentHistory(userId);
      emit(PaymentLoaded(payments));
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }
}
