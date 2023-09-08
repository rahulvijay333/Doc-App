import 'dart:developer';

import 'package:appoint_medic/application/slot/appointment_slot_bloc.dart';
import 'package:appoint_medic/infrastructure/appointment_slots/slot_service.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'slot_operations_event.dart';
part 'slot_operations_state.dart';

class SlotOperationsBloc
    extends Bloc<SlotOperationsEvent, SlotOperationsState> {
  final AppointmentSlotService appointmentSlotService;
  final AppointmentSlotBloc slotAuth;

  SlotOperationsBloc(this.appointmentSlotService, this.slotAuth)
      : super(SlotOperationsInitial()) {
    on<DeleteSlot>((event, emit) async {
      emit(SLoading());

      try {
        final response = await appointmentSlotService.deleteSlot(
            mainSlotID: event.mainSlotID,
            slodID: event.slotID,
           );

        if (response.isEmpty) {
          log('Response is empy , delete operation sucess');
          emit(SSucess('SucessFully slot deleted'));
          slotAuth
              .add(DeleteSlotLoadUpdate(date: event.date,));
        } else {
          log('Some error happend in slot operation bloc');
          emit(SFailure('Slot deletion failed'));
        }
      } catch (e) {
        log('Some error happend in slot operation bloc');
        emit(SFailure('error'));
      }
    });
  }
}
