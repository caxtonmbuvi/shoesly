import 'package:equatable/equatable.dart';
import 'package:shoesly/features/payment/models/payment_model.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentAdded extends PaymentState {}

class PaymentLoaded extends PaymentState {
  final List<Payment> payments;

  const PaymentLoaded(this.payments);

  @override
  List<Object> get props => [payments];
}

class PaymentError extends PaymentState {
  final String message;

  const PaymentError(this.message);

  @override
  List<Object> get props => [message];
}
