import 'dart:io';

import 'package:appoint_medic/application/profile/edit_profile/bloc/patient_edit_profile_bloc.dart';
import 'package:appoint_medic/application/profile/profile_details_bloc.dart';
import 'package:appoint_medic/domain/response_models/profile_model/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

enum Gender { male, female }

class ScreenPatientEdit extends StatefulWidget {
  const ScreenPatientEdit({super.key, required this.userDetails});
  final User userDetails;

  @override
  State<ScreenPatientEdit> createState() => _ScreenPatientEditState();
}

class _ScreenPatientEditState extends State<ScreenPatientEdit> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _houseNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _serviceController = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? imageFile;

  @override
  void initState() {
    _houseNameController.text =
        widget.userDetails.address?.houseName ?? '';
    _cityController.text = widget.userDetails.address?.city ?? '';
    _stateController.text = widget.userDetails.address?.state ?? '';
    _username.text = widget.userDetails.fullName ?? '';
    _gender.text = widget.userDetails.gender ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: size.height * 0.07,
              width: size.width,
              color: Colors.blue,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        //------------------------------pop function
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      )),
                  const Text(
                    'Edit',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  )
                ],
              ),
            ),
            Flexible(
              flex: 3,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  Container(
                                    height: size.height * 0.7 * 0.3,
                                    width: size.width * 0.45,
                                    // color: Colors.amber,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.withOpacity(0.2),
                                        image: (imageFile != null)
                                            ? DecorationImage(
                                                fit: BoxFit.cover,
                                                image: FileImage(imageFile!))
                                            : null),

                                    child: (imageFile == null)
                                        ? widget.userDetails.profilePicture ==
                                                null
                                            ? Image.asset('assets/patient.png',)
                                            : Image.network(
                                                widget.userDetails
                                                    .profilePicture!.secureUrl!,
                                                fit: BoxFit.cover,
                                              )
                                        : const SizedBox(),
                                  ),
                                  // Icon(Icons.add_a_photo)
                                  IconButton(
                                      onPressed: () {
                                        //-----------------------------------------------click to select photo
                                        showPhotoOptions();
                                      },
                                      icon: const Icon(
                                        Icons.add_a_photo_outlined,
                                        color: Colors.white,
                                      ))
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'full name required';
                            } else {
                              return null;
                            }
                          },
                          controller: _username,
                          decoration: const InputDecoration(
                            labelText: 'Full Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Gender required';
                            } else {
                              return null;
                            }
                          },
                          controller: _gender,
                          decoration: const InputDecoration(
                            labelText: 'Gender',
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                          onTap: () async {
                            Gender? selectedValue =
                                await _showGenderDialog(context);
                            if (selectedValue != null) {
                              // log(selectedValue.toString());
                              setState(() {
                                if (selectedValue == Gender.male) {
                                  _gender.text = 'male';
                                } else if (selectedValue == Gender.female) {
                                  _gender.text = 'female';
                                }
                              });
                            }
                          },
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),

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
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
              width: 130,
              child: ElevatedButton(onPressed: () {
                //-------------------------------------update function
                if (_formKey.currentState!.validate()) {
                  FormData pform = FormData.fromMap({
                    'username': _username.text,
                    'gender': _gender.text,
                    'houseName': _houseNameController.text,
                    'city': _cityController.text,
                    'state': _stateController.text,
                    'services': _serviceController.text,
                    'profilePic': imageFile == null
                        ? null
                        : MultipartFile.fromFileSync(imageFile!.path),
                  });

                  context
                      .read<PatientEditProfileBloc>()
                      .add(PatientProfileEditCall(patientForm: pform));
                }
              }, child:
                  BlocBuilder<PatientEditProfileBloc, PatientEditProfileState>(
                builder: (context, state) {
                  if (state is PatientProfileEditLoading) {
                    return const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Updating..'),
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            color: Colors.blue,
                          ),
                        )
                      ],
                    );
                  } else if (state is PatientProfileEditSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 3),
                          margin: EdgeInsets.all(15),
                          content: Text('Profile Updated Sucess')));

                      context
                          .read<ProfileDetailsBloc>()
                          .add(GetProfileDetails(widget.userDetails.id!));

                      context
                          .read<PatientEditProfileBloc>()
                          .add(ClearPatientEditProfileProcess());

                      Navigator.of(context).pop();
                    });
                  } else if (state is PatientProfileEditFailed) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 3),
                          margin: EdgeInsets.all(15),
                          content: Text('Profile Update failed')));

                      context
                          .read<PatientEditProfileBloc>()
                          .add(ClearPatientEditProfileProcess());
                    });
                  }

                  return const Text('Update');
                },
              )),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _houseNameController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _serviceController.dispose();
    super.dispose();
  }

  Future<Gender?> _showGenderDialog(BuildContext context) async {
    Gender selectedGender = Gender.male;

    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Select your gender'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    onTap: () {
                      setState(() {
                        selectedGender = Gender.male;
                      });
                    },
                    title: Row(
                      children: [
                        Radio<Gender>(
                          value: Gender.male,
                          activeColor: Colors.blue,
                          groupValue: selectedGender,
                          onChanged: (Gender? value) {
                            setState(() {
                              selectedGender = value!;
                            });
                          },
                        ),
                        const Text('Male'),
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        selectedGender = Gender.female;
                      });
                    },
                    title: Row(
                      children: [
                        Radio<Gender>(
                          value: Gender.female,
                          activeColor: Colors.blue,
                          groupValue: selectedGender,
                          onChanged: (Gender? value) {
                            setState(() {
                              selectedGender = value!;
                            });
                          },
                        ),
                        const Text('Female'),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(selectedGender);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(selectedGender);
              },
              child: const Text(
                'Ok',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
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
}
