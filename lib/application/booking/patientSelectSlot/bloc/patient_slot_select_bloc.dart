import 'package:appoint_medic/domain/response_models/booking_doctor_profile_slot_model/available_slot.dart';
import 'package:appoint_medic/infrastructure/booking/booking_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'patient_slot_select_event.dart';
part 'patient_slot_select_state.dart';

class PatientSlotSelectBloc
    extends Bloc<PatientSlotSelectEvent, PatientSlotSelectState> {
  final BookingService bookingService;

  PatientSlotSelectBloc(this.bookingService)
      : super(PatientSlotSelectInitial()) {
    List<AvailableSlot> searchResultSlots;
    on<DisplayAvailableSlots>((event, emit) async {
      emit(PatientDoctorSlotsLoading());

      final (error, response) =
          await bookingService.getDoctorProfileSlot(doctorid: event.doctorID);
      if (error.isEmpty) {
        if (response!.user!.availableSlots!.isEmpty) {
          emit(PatientDoctorSlotSucess(searchResultSlots: []));
        } else {
          List<AvailableSlot> doctorSlots = response.user!.availableSlots!;
          //---------------------------------------------searching
          searchResultSlots = doctorSlots
              .where((element) =>
                  element.date.toString().contains(event.searchDate))
              .toList();

          emit(PatientDoctorSlotSucess(searchResultSlots: searchResultSlots));
        }
      } else {
        emit(PatientDoctorSlotFailed('Error getting slots'));
      }
    });
  }
}
