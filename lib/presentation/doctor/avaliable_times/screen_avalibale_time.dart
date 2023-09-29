import 'dart:developer';

import 'package:appoint_medic/application/AlertSlotTime/add_slot_alert_box_bloc.dart';
import 'package:appoint_medic/application/slot/appointment_slot_bloc.dart';
import 'package:appoint_medic/presentation/doctor/avaliable_times/widgets/delete_dialoge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/color_constants.dart';

class ScreenAvailableTime extends StatefulWidget {
  const ScreenAvailableTime({
    super.key,
  });

  @override
  State<ScreenAvailableTime> createState() => _ScreenAvailableTimeState();
}

class _ScreenAvailableTimeState extends State<ScreenAvailableTime> {
  DateTime selectedDate = DateTime.now();
  String selectedDateFormatted =
      DateFormat('dd MMM yyyy').format(DateTime.now());

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;

        selectedDateFormatted = DateFormat('dd MMM yyyy').format(picked);

        BlocProvider.of<AppointmentSlotBloc>(context).add(GetSlotsListEvent(
          date: '${selectedDate.toLocal()}'.split(' ')[0],
        ));
      });
    }
  }

  @override
  void initState() {
    context.read<AppointmentSlotBloc>().add(LoadSlotsInitialData());

    super.initState();
  }

//-------------------------------------------------------------------add slot dialoge
  Future _addSlot(BuildContext context, DateTime date) async {
    TimeOfDay? selectedStartTime;
    TimeOfDay? selectedEndTime;

    String formatTime(TimeOfDay? time) {
      if (time == null) {
        return "select time";
      }

      final now = DateTime.now();
      final datetime =
          DateTime(now.year, now.month, now.day, time.hour, time.minute);
      final formattedTime = DateFormat.jm().format(datetime);
      return formattedTime;
    }

    return AddSlotDialoge(
        context, selectedStartTime, formatTime, date, context);
  }
  //------------------------------------------------------------------<<<<add slot dialoge

  @override
  Widget build(BuildContext contextAvailableTimings) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        // mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size.height * 0.07,
            width: size.width,
            color: appBackGround,
            child:  Center(
              child: Text(
                'Available Timings',
                style: TextStyle(
                    fontSize: size.width * 0.055,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Container(
              child:  Text(
                'Date',
                style: TextStyle(fontSize: size.width * 0.04, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 20,
            ),
            child: GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    //-------------------------------------display date
                    width: size.width * 0.4,
                    height: 40,
                    color: Colors.white,
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.calendar_month),
                        SizedBox(width: size.width *0.4*0.02,),
                        Text(
                          selectedDateFormatted,
                          style: TextStyle(fontSize: size.width * 0.4 * 0.10),
                        ),
                      ],
                    ))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Container(
              child:  Text(
                'Slots',
                style: TextStyle(fontSize: size.width * 0.04, fontWeight: FontWeight.w500),
              ),
            ),
          ),
    //------------------------------------------2nd column
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  height: size.height * 0.45,
                  width: size.width,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BlocBuilder<AppointmentSlotBloc, AppointmentSlotState>(
                      builder: (context, state) {
                        if (state is SlotLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is SlotSuccess) {
                          if (state.slotlist.filteredSlots!.isEmpty) {
                            return const SizedBox(
                              child: Center(child: Text('No Slots Added')),
                            );
                          }
    
                          if (state.slotlist.filteredSlots![0].slots!.isEmpty) {
                            return const SizedBox(
                              child: Center(child: Text('No Slots Added')),
                            );
                          } else {
                            return GridView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  state.slotlist.filteredSlots![0].slots!.length,
                              gridDelegate:
                                   SliverGridDelegateWithMaxCrossAxisExtent(
                                      mainAxisExtent: 40,
                                      // mainAxisSpacing: 20,
                                      crossAxisSpacing: size.width * 0.01,
                                      maxCrossAxisExtent: size.width*0.46
                                      
                                      ),
                              itemBuilder: (context, index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    color: state.slotlist.filteredSlots![0]
                                                .slots![index].status ==
                                            false
                                        ? Colors.blue[100]
                                        : Colors.red[100],
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                            width: size.width * 0.01,
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Text(
                                              '${state.slotlist.filteredSlots![0].slots![index].startTime} -  ${state.slotlist.filteredSlots![0].slots![index].endTime}',
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: size.width > 600
                                                      ? 18
                                                      : size.width * 0.46 * 0.07),
                                            ),
                                          ),
                                          Expanded(
                                              child: state
                                                          .slotlist
                                                          .filteredSlots![0]
                                                          .slots![index]
                                                          .status! ==
                                                      false
                                                  ? IconButton(
                                                      onPressed: () {
                                                        // log(contextAvailableTimings.widget.toString());
                                                        // ------------------delete functon pls complete
                                                        showDialog(
                                                          context: context,
                                                          builder: (ctx) {
                                                            return DeleteSlotDialoge(
                                                              contextAT:
                                                                  contextAvailableTimings,
                                                              slotID: state
                                                                  .slotlist
                                                                  .filteredSlots![
                                                                      0]
                                                                  .slots![index]
                                                                  .id!,
                                                              mainSlotID: state
                                                                  .slotlist
                                                                  .filteredSlots![
                                                                      0]
                                                                  .id!,
    
                                                              date:
                                                                  '${selectedDate.toLocal()}'
                                                                      .split(
                                                                          ' ')[0],
                                                              // );
                                                            );
                                                          },
                                                        );
                                                      },
                                                      icon: const Icon(
                                                        Icons.cancel,
                                                        size: 16,
                                                      ))
                                                  : const Icon(
                                                      Icons.lock,
                                                      size: 16,
                                                    ))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        } else if (state is SlotFailure) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //-------------------------------------------------------refresh
                              const Text('Error Occured'),
                              IconButton(
                                  onPressed: () {
                                    context
                                        .read<AppointmentSlotBloc>()
                                        .add(GetSlotsListEvent(
                                          date: '${selectedDate.toLocal()}'
                                              .split(' ')[0],
                                        ));
                                  },
                                  icon: const Icon(Icons.refresh))
                            ],
                          );
                        }
    
                        return const SizedBox(
                          child: Center(child: Text('No Slots To Show')),
                        );
                      },
                    ),
                  )),
            ),
          ),
    
          SizedBox(
            height: size.height * 0.01,
          ),
          Center(
            child: SizedBox(
              width: size.width *0.4,
              height: 40,
              child: ElevatedButton(
                  onPressed: () {
                    _addSlot(context, selectedDate);
                  },
                  child:  Text('Add Slot',style: TextStyle(fontSize: size.width * 0.4 *0.08),)),
            ),
          )
          //--------------------------------------------------------------------date
        ],
      ),
    );
  }

  Future<dynamic> AddSlotDialoge(
      BuildContext context,
      TimeOfDay? selectedStartTime,
      String formatTime(TimeOfDay? time),
      DateTime date,
      BuildContext snackContext) {
    return showDialog(
      context: context,
      builder: (ctx) {
        bool isError = false;

        log("${snackContext.widget.toString()} - showdiolog slot");
        return BlocBuilder<AddSlotAlertBoxBloc, AddSlotAlertBoxState>(
          builder: (context, state) {
            return AlertDialog(
              title: const Text('Add slot'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Start Time : '),
                      GestureDetector(
                        onTap: () async {
                          final TimeOfDay? startTime = await showTimePicker(
                            initialEntryMode: TimePickerEntryMode.input,
                            helpText: 'Starting time',
                            context: context,
                            initialTime: selectedStartTime ?? TimeOfDay.now(),
                          );
                          //--------------------------------------------------------start time updating bloc
                          BlocProvider.of<AddSlotAlertBoxBloc>(context)
                              .add(ShowSelectedStartTime(startTime));
                        },
                        child: Container(
                          width: 180,
                          height: 40,
                          color: Colors.grey.withOpacity(0.2),
                          child: Center(
                              //---------------------------------------------display time
                              child: Text(
                            formatTime(state.selectedStartTime),
                            maxLines: 1,
                          )),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('End Time   : '),
                      GestureDetector(
                        onTap: () async {
                          final TimeOfDay? endTime = await showTimePicker(
                            initialEntryMode: TimePickerEntryMode.input,
                            helpText: 'Ending time',
                            context: context,
                            initialTime: selectedStartTime ?? TimeOfDay.now(),
                          );
                          //----------------------------end time updating bloc

                          BlocProvider.of<AddSlotAlertBoxBloc>(context)
                              .add(ShowSelectedEndTime(endTime));
                        },
                        child: Container(
                            width: 180,
                            height: 40,
                            color: Colors.grey.withOpacity(0.2),
                            child: Center(
                                //-----------------------------------display end time
                                child: Text(
                              formatTime(state.selectedEndTime),
                              maxLines: 1,
                            ))),
                      )
                    ],
                  ),
                  // Visibility(
                  //     visible: isError,
                  //     child: Container(
                  //       child: const Text('Error'),
                  //     ))
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      BlocProvider.of<AddSlotAlertBoxBloc>(context)
                          .add(ClearAlertBoxTime());
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () {
                      if (state.selectedEndTime == state.selectedStartTime) {
                        setState(() {
                          isError = true;
                        });
                      } else {
                        setState(() {
                          isError = false;
                        });
                      }

                      if (state.selectedEndTime != null &&
                          state.selectedStartTime != null &&
                          state.selectedEndTime != state.selectedStartTime) {
                        //-----------------------------------------add slot

                        BlocProvider.of<AppointmentSlotBloc>(context).add(
                            AddSlotEvent(
                                date: '${date.toLocal()}'.split(' ')[0],
                                startTime: formatTime(state.selectedStartTime),
                                endTime: formatTime(state.selectedEndTime),
                                context: snackContext));

                        BlocProvider.of<AddSlotAlertBoxBloc>(context)
                            .add(ClearAlertBoxTime());

                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Ok'))
              ],
            );
          },
        );
      },
    );
  }
}
