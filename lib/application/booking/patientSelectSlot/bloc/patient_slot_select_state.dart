part of 'patient_slot_select_bloc.dart';

class PatientSlotSelectState {}

class PatientSlotSelectInitial extends PatientSlotSelectState {}

class PatientDoctorSlotsLoading extends PatientSlotSelectState {}

class PatientDoctorSlotSucess extends PatientSlotSelectState {
  final List<AvailableSlot> searchResultSlots;

  PatientDoctorSlotSucess({required this.searchResultSlots});
}

class PatientDoctorSlotFailed extends PatientSlotSelectState {
  final String errorMessage;

  PatientDoctorSlotFailed(this.errorMessage);
}
