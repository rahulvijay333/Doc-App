part of 'appointment_slot_bloc.dart';

class AppointmentSlotEvent {}

class GetSlotsListEvent extends AppointmentSlotEvent {
  final String date;
  final String token;

  GetSlotsListEvent({required this.date, required this.token});
}

class LoadSlotsInitialData extends AppointmentSlotEvent {
  final String token;

  LoadSlotsInitialData(this.token);
}

class AddSlotEvent extends AppointmentSlotEvent {
  final String date;
  final String startTime;
  final String endTime;
  final String token;
  final BuildContext context;

  AddSlotEvent({
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.token,
    required this.context,
  });
}

class deleteSlotEvent extends AppointmentSlotEvent {
  final String mainSlotID;
  final String slotID;
  final String token;
  final String date;
  final BuildContext context;

  deleteSlotEvent(
      {required this.mainSlotID,
      required this.slotID,
      required this.token,
      required this.date,
      required this.context});
}

class DeleteSlotLoadUpdate extends AppointmentSlotEvent {
  final String date;

  final String token;

  DeleteSlotLoadUpdate({required this.date, required this.token});
}
