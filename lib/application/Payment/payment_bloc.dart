import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<PaymentButtonLoading>((event, emit) {
      emit(PayButtonStartLoading());
    });

    on<PaymentButtonStopLoading>((event, emit) {
      emit(PayButtonStopLoading());
    });
  }
}
