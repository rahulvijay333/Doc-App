part of 'add_slot_alert_box_bloc.dart';

@immutable
sealed class AddSlotAlertBoxEvent {}

class ShowSelectedStartTime extends AddSlotAlertBoxEvent {
  final TimeOfDay? selectedStartTime;

  ShowSelectedStartTime(this.selectedStartTime);
}

class ShowSelectedEndTime extends AddSlotAlertBoxEvent {
  final TimeOfDay? selectedEndTime;

  ShowSelectedEndTime(this.selectedEndTime);
}

class ClearAlertBoxTime extends AddSlotAlertBoxEvent {}
