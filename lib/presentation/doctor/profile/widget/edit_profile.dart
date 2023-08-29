import 'dart:developer';
import 'dart:io';

import 'package:appoint_medic/application/doctor%20profile/bloc/doctor_profile_bloc.dart';
import 'package:appoint_medic/application/doctor%20profile/edit_profile/bloc/doctor_profile_edit_bloc.dart';
import 'package:appoint_medic/application/profile/profile_details_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ScreenEditProfDoct extends StatefulWidget {
  const ScreenEditProfDoct(
      {super.key,
      required this.image,
      required this.houseName,
      required this.city,
      required this.state,
      required this.service,
      required this.id});

  final String image;
  final String houseName, city, state;
  final List<String> service;
  final String id;

  @override
  State<ScreenEditProfDoct> createState() => _ScreenEditProfDoctState();
}

class _ScreenEditProfDoctState extends State<ScreenEditProfDoct> {
  final TextEditingController _houseNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _serviceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? imageFile;

  @override
  void initState() {
    List<String> services = widget.service;
    String service = services.join(',');

    _houseNameController.text = widget.houseName;
    _cityController.text = widget.city;
    _stateController.text = widget.state;
    _serviceController.text = service;
    super.initState();
  }

  @override
  void dispose() {
    _houseNameController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _serviceController.dispose();
    super.dispose();
  }

  //----------------------select image

  void selectImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

//-------------------------------------------get photo
  void showPhotoOptions() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Upload Profile Photo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  selectImage(ImageSource.gallery);
                },
                leading: const Icon(Icons.photo),
                title: const Text('Select from Gallery'),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(ctx).pop();
                  selectImage(ImageSource.camera);
                },
                leading: const Icon(Icons.camera),
                title: const Text('Select from Camera'),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              //-------------------------------------------------app bar
              Container(
                height: size.height * 0.07,
                color: Colors.blue,
                width: size.width,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          //----------------pop function
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        )),
                    const Text(
                      'Edit',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),

              //------------------------------------------------<<<<--------------------
              //----------------------------------------profile photo
              Flexible(
                flex: 4,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  Container(
                                    height: size.height * 0.7 * 0.3,
                                    width: size.width * 0.5,
                                    // color: Colors.amber,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.withOpacity(0.5),
                                        image: (imageFile != null)
                                            ? DecorationImage(
                                                fit: BoxFit.cover,
                                                image: FileImage(imageFile!))
                                            : null),

                                    child: (imageFile == null)
                                        ? widget.image.isNotEmpty
                                            ? Image.network(
                                                widget.image,
                                                fit: BoxFit.cover,
                                              )
                                            : const SizedBox()
                                        : const SizedBox(),
                                  ),
                                  // Icon(Icons.add_a_photo)
                                  IconButton(
                                      onPressed: () {
                                        //-----------------------------------------------click to select photo
                                        showPhotoOptions();
                                      },
                                      icon: const Icon(
                                          Icons.add_a_photo_outlined))
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        //-------------------------------------------housenmae
                        TextFormField(
                          controller: _houseNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'House name required';
                            } else {
                              return null;
                            }
                          },
                          // controller: ,
                          decoration: const InputDecoration(
                            labelText: 'House name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        //-------------------------------------------------city
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'City';
                            } else {
                              return null;
                            }
                          },
                          controller: _cityController,
                          decoration: const InputDecoration(
                            labelText: 'City',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),

                        //-------------------------------------

                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'State';
                            } else {
                              return null;
                            }
                          },
                          controller: _stateController,
                          decoration: const InputDecoration(
                            labelText: 'State',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),

                        //---------------------------------------------------service
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Service required';
                            } else {
                              return null;
                            }
                          },
                          controller: _serviceController,
                          decoration: const InputDecoration(
                            labelText: 'Services',
                            border: OutlineInputBorder(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              //-----------------<<<<<------
              SizedBox(
                height: 40,
                width: 150,
                child: ElevatedButton(onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    FormData dform = FormData.fromMap({
                      'houseName': _houseNameController.text,
                      'city': _cityController.text,
                      'state': _stateController.text,
                      'services': _serviceController.text,
                      'profilePic': imageFile == null
                          ? null
                          : MultipartFile.fromFileSync(imageFile!.path),
                    });

                    context
                        .read<DoctorProfileEditBloc>()
                        .add(DoctorProfileEditCall(doctorForm: dform));
                  }
                }, child:
                    //----------------------------------------------------------------------------bloc call
                    BlocBuilder<DoctorProfileEditBloc, DoctorProfileEditState>(
                  builder: (context, state) {
                    //---------------------------------------------loading
                    if (state is DoctorProfileEditLoading) {
                      log('loading state');
                      // return const Center(
                      //   child: CircularProgressIndicator(
                      //     strokeWidth: 1,
                      //   ),
                      // );
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Updating..'),
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: Center(child: CircularProgressIndicator(strokeWidth: 1,color: Colors.white,)))
                        ],
                      );
                    }
                    //-----------------------------------------------sucess
                    else if (state is DoctorProfileEditSuccess) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                duration: Duration(seconds: 3),
                                margin: EdgeInsets.all(15),
                                content: Text('Profile Updated Sucess')));
                        context
                            .read<DoctorProfileBloc>()
                            .add(GetDoctorProfileCall());

                        context
                            .read<DoctorProfileEditBloc>()
                            .add(ClearDoctorEditProcessCall());

                        Navigator.of(context).pop();
                      });
                    }
                    //----------------------------------------------failed
                    else if (state is DoctorProfileEditFailed) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                duration: Duration(seconds: 3),
                                margin: EdgeInsets.all(15),
                                content: Text('Profile Update Failed')));

                        context
                            .read<DoctorProfileEditBloc>()
                            .add(ClearDoctorEditProcessCall());
                      });
                    }
                    return const Text('Update');
                  },
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
