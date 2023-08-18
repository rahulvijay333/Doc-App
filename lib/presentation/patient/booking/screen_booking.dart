

import 'dart:developer';

import 'package:appoint_medic/application/booking/patientSelectSlot/bloc/patient_slot_select_bloc.dart';
import 'package:appoint_medic/domain/response_models/doctors_response_model/doctor.dart';
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
        //log('${selectedDate.toLocal()}'.split(' ')[0]);

        
        String formattedDate = DateFormat('dd MMM,y').format(selectedDate);

        log(formattedDate.toString());

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
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //----------------------------------------------------appbar
            AppbarCustom(size: size),
            //------------------------------------------->>>appbar

            //doctor details
            const Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15, bottom: 15, top: 10),
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
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              widget.doctor.speciality!.name!,
                            ),
                            const SizedBox(
                              height: 50,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.chat_rounded,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Icon(Icons.videocam)
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Payment',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '${widget.doctor.speciality!.fees!} Rs',
                                  style: const TextStyle(color: Colors.blue),
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
              padding:
                  EdgeInsets.only(left: 15.0, right: 15, bottom: 5, top: 10),
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
                          const Icon(Icons.calendar_month,size: 22,),
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

            //-----------------------display slots

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
              padding: EdgeInsets.only(
                left: 15.0,
                right: 15,
                bottom: 5,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  
                  height: 200,
                  color: Colors.blue.withOpacity(0.2),
                  child:
                      BlocBuilder<PatientSlotSelectBloc, PatientSlotSelectState>(
                    builder: (context, state) {
                      if (state is PatientDoctorSlotsLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is PatientDoctorSlotSucess) {
                        if (state.searchResultSlots.isEmpty) {
                          return Container(
                            child: Center(child: Text('No Slots Available')),
                          );
                        } else if(state.searchResultSlots[0].slots!.isEmpty){
              
                             return Container(
                            child: Center(child: Text('No Slots Available')),
                          );
              
              
                        }
              
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: state.searchResultSlots[0].slots!.length,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    mainAxisExtent: 30,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 20,
                                    maxCrossAxisExtent: 180),
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  color: Colors.white,
                                  child: Center(
                                    child: Text(
                                            '${state.searchResultSlots[0].slots![index].startTime} -  ${state.searchResultSlots[0].slots![index].endTime}',
                                            maxLines: 1,
                                          
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
              
                      else if(state is PatientDoctorSlotFailed) {
                       return Container(
                        child: Center(child: Text('No Slots Available')),
                      );
                      }
              
                      return Container(
                        child: Center(child: Text('No Slots Available')),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Center(
          
              child: SizedBox(
                height: 40,
                width: 150,
                child: ElevatedButton(onPressed: () {
                  //-----------------------------------------------booking proceed next
                }, child: Text('Proceed')),
              ),
            )
          ],
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
