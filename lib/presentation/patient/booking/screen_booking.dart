import 'dart:developer';

import 'package:appoint_medic/application/booking/patientSelectSlot/bloc/patient_slot_select_bloc.dart';
import 'package:appoint_medic/application/booking/patientTrackBooking/bloc/booking_tracker_bloc.dart';
import 'package:appoint_medic/core/color_constants.dart';
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
  final TextEditingController reasonCntroller = TextEditingController();
  DateTime selectedDate = DateTime.now();
  
  int selectedSlotIndex =
      -1; 

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
  Widget build(BuildContext context1) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
      
        body: WillPopScope(
          onWillPop: () async {
            //

            //------------------------------------------------------------clear selcted date
            context.read<BookingTrackerBloc>().add(BookingTrackClear());
            //---------------------<<<<<<<<<---------------------------------

            ScaffoldMessenger.of(context).clearSnackBars();
            Navigator.of(context).pop();
            return true;
          },
          child: Column(
            children: [
              AppbarCustom(size: size),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //----------------------------------------------------appbar

                      //------------------------------------------->>>appbar

                      //doctor details
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, bottom: 14, top: 10),
                        child: Text(
                          'Doctor details',
                          style: TextStyle(
                              fontSize: size.width * 0.04,
                              color: Colors.blue,
                              fontWeight: FontWeight.w500),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15),
                        child: Container(
                          //--------------------------------------------------------image
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
                                    width: size.width * 0.3,
                                    child: Image.network(
                                        widget.doctor.profilePicture
                                                ?.secureUrl ??
                                            '',
                                        fit: BoxFit.cover, loadingBuilder:
                                            (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;

                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }, errorBuilder:
                                            (context, error, stackTrace) {
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
                                SizedBox(
                                  width: size.width * 0.04,
                                ),
                                //doctor details widget
                                DoctorDetailsCustom(
                                  size: size,
                                  widget: widget,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //doctor details
                      Padding(
                        //---------------------------------------------------------------------------date
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, bottom: 14, top: 10),
                        child: Text(
                          'Date',
                          style: TextStyle(
                              fontSize: size.width * 0.04,
                              color: Colors.blue,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      //------------------------------------------------display date
                      GestureDetector(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                                //-------------------------------------display date
                                height: 40,
                                width: size.width * 0.5,
                                color: Colors.blue.withOpacity(0.2),
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      color: appBackGround,
                                      size: size.width * 0.5 * 0.13,
                                    ),
                                    SizedBox(
                                      width: size.width * 0.5 * 0.1,
                                    ),
                                    Text(
                                      DateFormat('dd MMM ,y')
                                          .format(selectedDate),
                                      // '${selectedDate.toLocal()}'.split(' ')[0],
                                      style: TextStyle(
                                          fontSize: size.width * 0.5 * 0.08),
                                    ),
                                  ],
                                ))),
                          ),
                        ),
                      ),

                      //----------------------------------------------------------------------------------display slots

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, bottom: 14, top: 10),
                        child: Text(
                          'Available slots',
                          style: TextStyle(
                              fontSize: size.width * 0.04,
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
                                          child: Text('Doctor not available')),
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
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state
                                          .searchResultSlots[0].slots!.length,
                                      gridDelegate:
                                           SliverGridDelegateWithMaxCrossAxisExtent(
                                              mainAxisExtent: 40,
                                              mainAxisSpacing: size.width * 0.03,
                                              crossAxisSpacing: size.width * 0.02,
                                              maxCrossAxisExtent: 180),
                                      itemBuilder: (context, index) {
                                        final isSlotSelected =
                                            selectedSlotIndex == index;
                                        return InkWell(
                                          onTap: () {
                                            //------------------------------------------------send booking details

                                            if (state.searchResultSlots[0]
                                                    .slots![index].status ==
                                                true) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      duration:
                                                          Duration(seconds: 1),
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      margin:
                                                          EdgeInsets.all(15),
                                                      content: Text(
                                                          'Slot already booked')));
                                              return;
                                            } else if (selectedSlotIndex ==
                                                index) {
                                              context
                                                  .read<BookingTrackerBloc>()
                                                  .add(BookingTrackClear());

                                              // If the slot is already selected, deselect it

                                              setState(() {
                                                selectedSlotIndex =
                                                    -1; // Deselect the slot
                                              });
                                            } else {
                                              // If the slot is available and not already selected, select it
                                              setState(() {
                                                selectedSlotIndex =
                                                    index; // Update the selected slot index
                                              });
                                              final bookingDetails = BookingDetails(
                                                  date: state
                                                      .searchResultSlots[0].date
                                                      .toString(),
                                                  fees: int.parse(widget
                                                      .doctor.speciality!.fees
                                                      .toString()),
                                                  doctorID: widget.doctor.id!,
                                                  dateID: state
                                                      .searchResultSlots[0].id!,
                                                  slotID: state
                                                      .searchResultSlots[0]
                                                      .slots![index]
                                                      .id!,
                                                  startTime: state
                                                      .searchResultSlots[0]
                                                      .slots![index]
                                                      .startTime
                                                      .toString(),
                                                  endTime: state
                                                      .searchResultSlots[0]
                                                      .slots![index]
                                                      .endTime!);
                                              //---------------------------------------------------------bloc call
                                              context
                                                  .read<BookingTrackerBloc>()
                                                  .add(BookingSelectSlot(
                                                      bookingDetails:
                                                          bookingDetails,
                                                      doct: widget.doctor));
                                            }
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                              color: state
                                                          .searchResultSlots[0]
                                                          .slots![index]
                                                          .status ==
                                                      false
                                                  ? isSlotSelected
                                                      ? Colors.blue
                                                          .withOpacity(0.5)
                                                      : Colors.white
                                                  : Colors.white,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        '${state.searchResultSlots[0].slots![index].startTime} -  ${state.searchResultSlots[0].slots![index].endTime}',
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            fontSize:
                                                                size.width *
                                                                    0.028),
                                                      ),
                                                      state
                                                                  .searchResultSlots[
                                                                      0]
                                                                  .slots![index]
                                                                  .status ==
                                                              false
                                                          ? isSlotSelected
                                                              ? const Icon(
                                                                  Icons
                                                                      .timer_outlined,
                                                                  size: 15,
                                                                  color: Colors
                                                                      .white)
                                                              : const Icon(
                                                                  Icons
                                                                      .timer_outlined,
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
                                  child: const Center(
                                      child: Text('No Slots Available')),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.width * 0.01,
                      ),
                      //-------------------------------------------------------------------------selected slot
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: BlocBuilder<BookingTrackerBloc,
                            BookingTrackerState>(
                          builder: (context, state) {
                            //----------------------------------------------------------------------loading bloc state
                            if (state is Bookingloading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            //----------------------------------------------------------------------selected slot state
                            else if (state is BookingTrackerSelected) {
                              return Center(
                                child: SizedBox(
                                  height: 40,
                                  width: size.width * 0.40,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        //-----------------------------------------------booking proceed next

                                        context.read<BookingTrackerBloc>().add(
                                            BookingStartApiCallOrderID(
                                                bookingDetails:
                                                    state.bookingDetails,
                                                doct: state.doct));
                                      },
                                      child: Text(
                                        'Proceed',
                                        style: TextStyle(
                                            fontSize: size.width * 0.40 * 0.08),
                                      )),
                                ),
                              );
                            }

                            //-----------------------------------------------------------------again back to intial state bloc
                            else if (state is BookingTrackerInitial) {
                              return Center(
                                child: SizedBox(
                                  height: 40,
                                  width: size.width * 0.40,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        //-----------------------------------------------booking not selected error
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                duration: Duration(seconds: 1),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.all(15),
                                                content: Text(
                                                    'select slot to proceed')));
                                      },
                                      child: Text(
                                        'Proceed',
                                        style: TextStyle(
                                            fontSize: size.width * 0.40 * 0.08),
                                      )),
                                ),
                              );
                            } else if (state is BookingGotOrderID) {
                              //--------------------------------------if order id is received move to confirmation page
                              WidgetsBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context1) {
                                    return ScreenConfirmBooking(
                                      bookingdetails: state.bookingDetails,
                                      doc: state.doct,
                                    );

                                    // return ScreenConfirmBooking();
                                  },
                                ));
                              });
                            } else if (state is BookingOrderIDFailed) {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        duration: const Duration(seconds: 1),
                                        margin: const EdgeInsets.all(15),
                                        content: Text(state.error)));
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
            ],
          ),
        ),
      ),
    );
  }
}

class DoctorDetailsCustom extends StatelessWidget {
  const DoctorDetailsCustom({
    super.key,
    required this.size,
    required this.widget,
  });

  final Size size;
  final ScreenBooking widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      height: size.height * 0.15,
      width: size.width * 0.40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dr.${widget.doctor.fullName!}',
            style: TextStyle(
                fontSize: size.width * 0.05, fontWeight: FontWeight.w500),
          ),
          Text(
            widget.doctor.speciality!.name!,
            style: TextStyle(fontSize: size.width * 0.038),
          ),
          SizedBox(
            height: size.width * 0.04,
          ),
          Row(
            children: [
              Text(
                'Fees :',
                style: TextStyle(fontSize: size.width * 0.036),
              ),
              Text(
                '${widget.doctor.speciality!.fees!} Rs',
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.blue, fontSize: size.width * 0.036),
              )
            ],
          ),
        ],
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
          Text(
            'Appointment',
            style: TextStyle(
              fontSize: size.width * 0.04,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
