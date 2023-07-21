import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: size.height * 0.50,
          width: double.maxFinite,
          color: Colors.blue,
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.15,
                // color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //welcome
                      SizedBox(
                          //color: Colors.amber,
                          width: size.width * 0.20,
                          height: size.height * 0.15 * 0.80,
                          child: const CircleAvatar(
                            backgroundImage: AssetImage('assets/patient.png'),
                          )),

                      //---------------------------------------name and welcome

                      SizedBox(
                        width: size.width * 0.60,
                        height: size.height * 0.15 * 0.80,
                        //color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Welcome',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                name,
                                style: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),

                      const Spacer(),
                      //------------------------------------------reminder icon
                      SizedBox(
                        height: size.height * 0.15 * 0.50,
                        width: size.width * 0.12,
                        child: CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.5),
                          child: CircleAvatar(
                            radius: 23,
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.notifications)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.15,
                //  color: Colors.redAccent,

                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8)),
                      child: const Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.search),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Search doctors ..')
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: size.width,
            height: size.height * 0.65,
            decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60))),
            child: Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.07,
                  right: size.width * 0.07,
                  top: size.height * 0.65 * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'My Appointments',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // Expanded(
                  //     child: Container(
                  //         child: const Center(child: Text('No Appointments'))))
                  Expanded(
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                                height: 110,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.0, right: 10, top: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Date : 24/8/2023'),
                                          Text('Time: 4:00pm')
                                        ],
                                      ),
                                    ),
                                    ListTile(
                                      leading: const CircleAvatar(
                                        radius: 35,
                                        backgroundImage:
                                            AssetImage('assets/doctor.png'),
                                      ),
                                      title: const Text('Doctor Name'),
                                      subtitle:
                                          const Text('Department / speciality'),
                                      trailing: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.message,
                                            color: Colors.blue,
                                          )),
                                    )
                                  ],
                                )),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: 10),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
