import 'package:appoint_medic/core/color_constants.dart';
import 'package:appoint_medic/presentation/patient/messages/widget/message_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ScreenMessages extends StatelessWidget {
  const ScreenMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Container(
        width: double.maxFinite,
        height: double.maxFinite,
        // decoration: backgroundDecoration,
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.07,
                child: const Center(
                  child: Text(
                'Messages',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
                ),
              ),
              
              SizedBox(
                height: size.height * 0.05,
              ),
              //----------------------------------------------------------search messages
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(10),
                    child: Container(
                      color: Colors.grey[200],
                      //height: 40,
                      height: size.height * 0.06,
                      width: size.width * 0.75,

                      child: const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Icon(Icons.search),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Search Messages..')
                          ],
                        ),
                      ),
                    ),
                  ),

                  //---------------------------------------------new message icon
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(10),
                    child: Container(
                      height: size.height * 0.06,
                      width: size.width * 0.15,
                      color: Colors.blue,
                      child: IconButton(
                          onPressed: () {
                            //----------------------------message function
                          },
                          icon: const Icon(
                            Icons.add_comment,
                            size: 30,
                            color: Colors.white,
                          )),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              //-------------------------------list of messages
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            height: size.height * 0.10,
                            color: Colors.blue[50]?.withOpacity(0.5),
                            child: MessageTile(
                                senderName: 'Dr. alex Emanuel',
                                message: 'hello',
                                time: '4:00pm')),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: 10),
              ),
            ],
          ),
        ));
  }
}
