part of 'slot_operations_bloc.dart';

class SlotOperationsEvent {}

class AddSlotEvent extends SlotOperationsEvent {}

class DeleteSlot extends SlotOperationsEvent {
  final String mainSlotID;
  final String slotID;
  final String token;
  final String date;
  final BuildContext context;

  DeleteSlot({
    required this.mainSlotID,
    required this.slotID,
    required this.token,
    required this.context,
    required this.date,
  });
}
