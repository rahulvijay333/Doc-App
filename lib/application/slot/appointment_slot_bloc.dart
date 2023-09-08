
import 'package:appoint_medic/domain/response_models/available_slot_response/available_slot_response.dart';
import 'package:appoint_medic/infrastructure/appointment_slots/slot_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'appointment_slot_event.dart';
part 'appointment_slot_state.dart';

//---------------------------------------------------------------------view slots details in ui
class AppointmentSlotBloc
    extends Bloc<AppointmentSlotEvent, AppointmentSlotState> {
  final AppointmentSlotService appointmentSlotService;

  AppointmentSlotBloc(this.appointmentSlotService)
      : super(AppointmentSlotInitial()) {
    on<GetSlotsListEvent>((event, emit) async {
      emit(SlotLoading());
      final (error, response) = await appointmentSlotService.getslotsByDate(
        date: event.date,
      );

      if (error.isEmpty) {
        emit(SlotSuccess(slotlist: response!));
      } else {
        emit(SlotFailure(error));
      }
    });

    on<LoadSlotsInitialData>((event, emit) async {
      emit(SlotLoading());
      final datetime = (DateTime.now().toLocal()).toString().split(' ')[0];

      final (error, response) = await appointmentSlotService.getslotsByDate(
        date: datetime,
      );

      if (error.isEmpty) {
        emit(SlotSuccess(slotlist: response!));
      } else {
        emit(SlotFailure(error));
      }
    });

    on<AddSlotEvent>((event, emit) async {
      // emit(SlotLoading());

      final response = await appointmentSlotService.addSlot(
        date: event.date,
        startTime: event.startTime,
        endTime: event.endTime,
      );

      if (response.isEmpty) {
        add(GetSlotsListEvent(date: event.date, ));
      } else {
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
          margin: const EdgeInsets.only(left: 20, bottom: 80, right: 20),
          content: Center(child: Text('Slot not added ,$response')),
          duration: const Duration(seconds: 5),
          behavior: SnackBarBehavior.floating,
        ));
      }
    });

    on<deleteSlotEvent>((event, emit) async {
      try {
        final response = await appointmentSlotService.deleteSlot(
          mainSlotID: event.mainSlotID,
          slodID: event.slotID,
        );

        if (response.isEmpty) {
          //event call
          add(GetSlotsListEvent(date: event.date,));

          //-------------------display message
          ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
            margin: EdgeInsets.only(left: 20, bottom: 80, right: 20),
            content: Center(child: Text('Deleted successfully')),
            duration: Duration(seconds: 5),
            behavior: SnackBarBehavior.floating,
          ));
        } else {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
            margin: const EdgeInsets.only(left: 20, bottom: 80, right: 20),
            content: Center(child: Text('Slot no deleted , $response')),
            duration: const Duration(seconds: 5),
            behavior: SnackBarBehavior.floating,
          ));
        }
      } catch (e) {
        //-----------------------------------------------------------------display message to ui
        ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
          margin: EdgeInsets.only(left: 20, bottom: 80, right: 20),
          content: Center(child: Text('Slot no deleted , Try Again')),
          duration: Duration(seconds: 5),
          behavior: SnackBarBehavior.floating,
        ));
      }
    });
  }
}
