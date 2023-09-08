part of 'appointment_slot_bloc.dart';

class AppointmentSlotEvent {}

class GetSlotsListEvent extends AppointmentSlotEvent {
  final String date;
  

  GetSlotsListEvent({required this.date, });
}

class LoadSlotsInitialData extends AppointmentSlotEvent {


  LoadSlotsInitialData();
}

class AddSlotEvent extends AppointmentSlotEvent {
  final String date;
  final String startTime;
  final String endTime;
  
  final BuildContext context;

  AddSlotEvent({
    required this.date,
    required this.startTime,
    required this.endTime,
   
    required this.context,
  });
}

class deleteSlotEvent extends AppointmentSlotEvent {
  final String mainSlotID;
  final String slotID;

  final String date;
  final BuildContext context;

  deleteSlotEvent(
      {required this.mainSlotID,
      required this.slotID,
   
      required this.date,
      required this.context});
}

class DeleteSlotLoadUpdate extends AppointmentSlotEvent {
  final String date;

  

  DeleteSlotLoadUpdate({required this.date,});
}
