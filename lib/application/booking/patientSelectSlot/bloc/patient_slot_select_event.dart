part of 'patient_slot_select_bloc.dart';

class PatientSlotSelectEvent {}

class DisplayAvailableSlots extends PatientSlotSelectEvent {
  final String doctorID;
  final String searchDate;

  DisplayAvailableSlots({required this.doctorID, required this.searchDate});
}
