import 'dart:developer';

import 'package:appoint_medic/application/booking/patientSelectSlot/bloc/patient_slot_select_bloc.dart';
import 'package:appoint_medic/application/booking/patientTrackBooking/bloc/booking_tracker_bloc.dart';
import 'package:appoint_medic/domain/models/bookingDetails/booking_details.dart';
import 'package:appoint_medic/domain/response_models/doctors_response_model/doctor.dart';
import 'package:appoint_medic/presentation/patient/booking/confirm_booking_3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ScreenBooking extends StatefulWidget {
  const ScreenBooking({super.key, required this.doctor});
  final Doctor doctor;

  @override
  State<ScreenBooking> createState() => _ScreenBookingState();
}

class _ScreenBookingState extends State<ScreenBooking> {
  DateTime selectedDate = DateTime.now();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;

        context.read<PatientSlotSelectBloc>().add(DisplayAvailableSlots(
              doctorID: widget.doctor.id!,
              searchDate: '${selectedDate.toLocal()}'.split(' ')[0],
            ));
      });
    }
  }

  @override
  void initState() {
    context.read<PatientSlotSelectBloc>().add(DisplayAvailableSlots(
          doctorID: widget.doctor.id!,
          searchDate: '${selectedDate.toLocal()}'.split(' ')[0],
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('Screen bokking');
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: WillPopScope(
          onWillPop: () async {
            //
            log('nbye bye ');
            //------------------------------------------------------------clear selcted date
            context.read<BookingTrackerBloc>().add(BookingTrackClear());
            //---------------------<<<<<<<<<---------------------------------

            ScaffoldMessenger.of(context).clearSnackBars();
            Navigator.of(context).pop();
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //----------------------------------------------------appbar
                AppbarCustom(size: size),
                //------------------------------------------->>>appbar

                //doctor details
                const Padding(
                  padding: EdgeInsets.only(
                      left: 15.0, right: 15, bottom: 15, top: 10),
                  child: Text(
                    'Doctor details',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)),
                    height: size.height * 0.20,
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: size.height * 0.16,
                              width: 150,
                              child: Image.network(
                                  widget.doctor.profilePicture?.secureUrl ?? '',
                                  fit: BoxFit.cover, loadingBuilder:
                                      (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;

                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }, errorBuilder: (context, error, stackTrace) {
                                if (widget.doctor.gender == 'female') {
                                  return Image.asset(
                                    'assets/female_doctor.png',
                                    fit: BoxFit.cover,
                                  );
                                } else {
                                  return Image.asset(
                                    'assets/doctor_male.png',
                                    fit: BoxFit.cover,
                                  );
                                }
                              }),
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Container(
                            // color: Colors.amber,
                            height: size.height * 0.16,
                            width: 170,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dr.${widget.doctor.fullName!}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  widget.doctor.speciality!.name!,
                                ),
                                const SizedBox(
                                  height: 35,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Payment',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      '${widget.doctor.speciality!.fees!} Rs',
                                      style:
                                          const TextStyle(color: Colors.blue),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //doctor details
                const Padding(
                  padding: EdgeInsets.only(
                      left: 15.0, right: 15, bottom: 5, top: 10),
                  child: Text(
                    'Date',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                //------------------------------------------------display date
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 215,
                    top: 5,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          //-------------------------------------display date
                          height: 40,
                          color: Colors.blue.withOpacity(0.2),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                size: 22,
                              ),
                              Text(
                                DateFormat('dd MMM ,y').format(selectedDate),
                                // '${selectedDate.toLocal()}'.split(' ')[0],
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ))),
                    ),
                  ),
                ),

                //----------------------------------------------------------------------------------display slots

                const Padding(
                  padding:
                      EdgeInsets.only(left: 15.0, right: 15, bottom: 5, top: 5),
                  child: Text(
                    'Available slots',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15,
                    bottom: 5,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 250,
                      color: Colors.blue.withOpacity(0.2),
                      //--------------------------------------------------------------------------------bloc
                      child: BlocBuilder<PatientSlotSelectBloc,
                          PatientSlotSelectState>(
                        builder: (context, state) {
                          if (state is PatientDoctorSlotsLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is PatientDoctorSlotSucess) {
                            if (state.searchResultSlots.isEmpty) {
                              return Container(
                                child: const Center(
                                    child: Text('No Slots Available')),
                              );
                            } else if (state
                                .searchResultSlots[0].slots!.isEmpty) {
                              return Container(
                                child: const Center(
                                    child: Text('No Slots Available')),
                              );
                            }

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    state.searchResultSlots[0].slots!.length,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        mainAxisExtent: 30,
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 20,
                                        maxCrossAxisExtent: 180),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      //------------------------------------------------send booking details

                                      if (state.searchResultSlots[0]
                                              .slots![index].status ==
                                          true) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.all(15),
                                                content: Text(
                                                    'Slot already booked')));
                                        return;
                                      }

                                      final bookingDetails = BookingDetails(
                                          date: state.searchResultSlots[0].date
                                              .toString(),
                                          fees: int.parse(widget
                                              .doctor.speciality!.fees
                                              .toString()),
                                          doctorID: widget.doctor.id!,
                                          dateID:
                                              state.searchResultSlots[0].id!,
                                          slotID: state.searchResultSlots[0]
                                              .slots![index].id!,
                                          startTime: state.searchResultSlots[0]
                                              .slots![index].startTime
                                              .toString(),
                                          endTime: state.searchResultSlots[0]
                                              .slots![index].endTime!);
                                      //---------------------------------------------------------bloc call
                                      context.read<BookingTrackerBloc>().add(
                                          BookingSelectSlot(
                                              bookingDetails: bookingDetails,
                                              doct: widget.doctor));
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        color: state.searchResultSlots[0]
                                                    .slots![index].status ==
                                                false
                                            ? Colors.white
                                            : Colors.red.withOpacity(0.2),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${state.searchResultSlots[0].slots![index].startTime} -  ${state.searchResultSlots[0].slots![index].endTime}',
                                                  maxLines: 1,
                                                ),
                                                state
                                                            .searchResultSlots[
                                                                0]
                                                            .slots![index]
                                                            .status ==
                                                        false
                                                    ? Icon(
                                                        Icons.timer_outlined,
                                                        size: 15,
                                                      )
                                                    : const Icon(
                                                        Icons.lock,
                                                        size: 15,
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else if (state is PatientDoctorSlotFailed) {
                            return Container(
                              child: const Center(
                                  child: Text('No Slots Available')),
                            );
                          }

                          return Container(
                            child:
                                const Center(child: Text('No Slots Available')),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                //-------------------------------------------------------------------------selected slot
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: BlocBuilder<BookingTrackerBloc, BookingTrackerState>(
                    builder: (context, state) {
                      //----------------------------------------------------------------------loading bloc state
                      if (state is Bookingloading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      //----------------------------------------------------------------------selected slot state
                      else if (state is BookingTrackerSelected) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Selected : ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    width: 170,
                                    height: 30,
                                    color: Colors.blue.withOpacity(0.2),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${state.bookingDetails.startTime} -  ${state.bookingDetails.endTime}',
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              //---------------------------------------------------clear selected itemds
                                              context
                                                  .read<BookingTrackerBloc>()
                                                  .add(BookingTrackClear());
                                            },
                                            child: const Icon(
                                              Icons.clear,
                                              size: 18,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: SizedBox(
                                height: 40,
                                width: 150,
                                child: ElevatedButton(
                                    onPressed: () {
                                      //-----------------------------------------------booking proceed next

                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //   builder: (context) {
                                      //     return ScreenConfirmBooking();
                                      //   },
                                      // ));

                                      context.read<BookingTrackerBloc>().add(
                                          BookingStartApiCallOrderID(
                                              bookingDetails:
                                                  state.bookingDetails,
                                              doct: state.doct));
                                    },
                                    child: const Text('Proceed')),
                              ),
                            )
                          ],
                        );
                      }

                      //-----------------------------------------------------------------again back to intial state bloc
                      else if (state is BookingTrackerInitial) {
                        return Center(
                          child: SizedBox(
                            height: 40,
                            width: 150,
                            child: ElevatedButton(
                                onPressed: () {
                                  //-----------------------------------------------booking not selected error
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          margin: EdgeInsets.all(15),
                                          content:
                                              Text('select slot to proceed')));
                                },
                                child: const Text('Proceed')),
                          ),
                        );
                      } else if (state is BookingGotOrderID) {
                        //--------------------------------------if order id is received move to confirmation page
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return ScreenConfirmBooking(
                                  bookingdetails: state.bookingDetails,
                                  doc: state.doct);

                              // return ScreenConfirmBooking();
                            },
                          ));
                        });
                      }
                      return const SizedBox();
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppbarCustom extends StatelessWidget {
  const AppbarCustom({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.07,
      color: Colors.blue,
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                //-------------------------------------------pop function
                context.read<BookingTrackerBloc>().add(BookingTrackClear());
                ScaffoldMessenger.of(context).clearSnackBars();
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              )),
          const Expanded(
              child: Text(
            'Appointment',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
        ],
      ),
    );
  }
}
