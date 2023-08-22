import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'add_slot_alert_box_event.dart';
part 'add_slot_alert_box_state.dart';

class AddSlotAlertBoxBloc
    extends Bloc<AddSlotAlertBoxEvent, AddSlotAlertBoxState> {
  AddSlotAlertBoxBloc() : super(AddSlotAlertBoxState(null, null)) {
    on<ShowSelectedStartTime>((event, emit) {
      emit(
          AddSlotAlertBoxState(event.selectedStartTime, state.selectedEndTime));
    });

    on<ShowSelectedEndTime>((event, emit) {
      emit(
          AddSlotAlertBoxState(state.selectedStartTime, event.selectedEndTime));
    });
    on<ClearAlertBoxTime>((event, emit) {
      emit(AddSlotAlertBoxState(null, null));
    });
  }
}
