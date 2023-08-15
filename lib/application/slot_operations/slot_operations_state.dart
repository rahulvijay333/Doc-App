part of 'slot_operations_bloc.dart';

class SlotOperationsState {}

class SlotOperationsInitial extends SlotOperationsState {}

class SLoading extends SlotOperationsState {}

class SSucess extends SlotOperationsState {
  final String message;

  SSucess(this.message);
}

class SFailure extends SlotOperationsState {
  final String errorMessage;

  SFailure(this.errorMessage);
}
