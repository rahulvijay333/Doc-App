import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'patient_booking_track_event.dart';
part 'patient_booking_track_state.dart';

class PatientBookingTrackBloc extends Bloc<PatientBookingTrackEvent, PatientBookingTrackState> {
  PatientBookingTrackBloc() : super(PatientBookingTrackInitial()) {
    on<PatientBookingTrackEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
