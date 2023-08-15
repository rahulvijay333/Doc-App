part of 'appointment_slot_bloc.dart';

@immutable
sealed class AppointmentSlotState {}

class AppointmentSlotInitial extends AppointmentSlotState {}

class SlotLoading extends AppointmentSlotState {}

class SlotSuccess extends AppointmentSlotState {
  final AvailableSlotResponse slotlist;

  SlotSuccess({required this.slotlist});
}

class SlotFailure extends AppointmentSlotState {
  final String errorMessage;

  SlotFailure(this.errorMessage);
}
