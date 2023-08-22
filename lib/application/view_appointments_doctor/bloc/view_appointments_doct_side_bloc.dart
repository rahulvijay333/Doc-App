import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'view_appointments_doct_side_event.dart';
part 'view_appointments_doct_side_state.dart';

class ViewAppointmentsDoctSideBloc
    extends Bloc<ViewAppointmentsDoctSideEvent, ViewAppointmentsDoctSideState> {
  ViewAppointmentsDoctSideBloc() : super(ViewAppointmentsDoctSideInitial()) {
    on<ViewAppointmentsDoctSideEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
