import 'dart:developer';
import 'dart:io';

import 'package:appoint_medic/application/Onboarding/on_boarding_bloc.dart';
import 'package:appoint_medic/application/login/login_bloc.dart';
import 'package:appoint_medic/domain/models/onboardingPatient/patient_onb_model.dart';
import 'package:appoint_medic/presentation/login/screen_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

enum Gender { male, female }

class ScreenOnBoardingPatient extends StatefulWidget {
  final String token;

  const ScreenOnBoardingPatient({super.key, required this.token});

  @override
  _ScreenOnBoardingPatientState createState() =>
      _ScreenOnBoardingPatientState();
}

class _ScreenOnBoardingPatientState extends State<ScreenOnBoardingPatient> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _houseNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  Color profileErrorColor = Colors.transparent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _genderController.dispose();

    _phoneController.dispose();
    _houseNameController.dispose();
    _cityController.dispose();
    _stateController.dispose();

    super.dispose();
  }

  bool profilePic = false;

  bool isloading = true;
  bool profileError = true;
  File? imageFile;

  //----------------------select image

  void selectImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        log(imageFile.toString());
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

//---------------------------------------------------select gender

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

//---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<LoginBloc>(context)
                    .add(LogOutButtonClicked('patient'));
                //---------------------------------------------------------------logout funtion
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => ScreenLogin(),
                ));
              },
              icon: const Icon(Icons.logout))
        ],
        title: const Text('Complete Registration'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    showPhotoOptions();
                  },
                  //------------------------------------photo section
                  child: Center(
                    child: Container(
                      width: 150,
                      height: 150,
                      // color: Colors.grey,
                      decoration: BoxDecoration(
                          border: Border.all(color: profileErrorColor),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.3),
                          image: (imageFile != null)
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(imageFile!))
                              : null),
                      child: (imageFile == null)
                          ? const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 50,
                                ),
                                Text('Photo')
                              ],
                            )
                          : null,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //--------------------------------full names
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'full name required';
                    } else {
                      return null;
                    }
                  },
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Gender required';
                    } else {
                      return null;
                    }
                  },
                  controller: _genderController,
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: () async {
                    Gender? selectedValue = await _showGenderDialog(context);
                    if (selectedValue != null) {
                      log(selectedValue.toString());
                      setState(() {
                        if (selectedValue == Gender.male) {
                          _genderController.text = 'male';
                        } else if (selectedValue == Gender.female) {
                          _genderController.text = 'female';
                        }
                      });
                    }
                  },
                ),
                const SizedBox(height: 16.0),

                //--------------------------------------phone
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'phone number required';
                    } else if (value.length < 10 || value.length > 10) {
                      return 'enter valid phone number';
                    } else {
                      return null;
                    }
                  },
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                //---------------------------------------house name
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'House name required';
                    } else {
                      return null;
                    }
                  },
                  controller: _houseNameController,
                  decoration: const InputDecoration(
                    labelText: 'House Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                //---------------------------------------city
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'city required';
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
                const SizedBox(height: 16.0),
                //--------------------------------------state
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'state required';
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
                const SizedBox(height: 16.0),

                const SizedBox(height: 10.0),
                Center(
                  child: BlocBuilder<OnBoardingBloc, OnBoardingState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          // Perform actions on form submission

                          // if (imageFile == null) {
                          //   setState(() {
                          //     profileErrorColor = Colors.red;
                          //   });
                          // } else {
                          //   setState(() {
                          //     profileErrorColor = Colors.transparent;
                          //   });
                          // }

                          if (_formkey.currentState!.validate()) {
                            log('VAlue are present');

                            // log(multi)

                            //---------------saving patient details to object
                            log('saving process');
                            final patient = PatientProfileFormData(
                                username: _fullNameController.text,
                                gender: _genderController.text,
                                phone: _phoneController.text,
                                houseName: _houseNameController.text,
                                city: _cityController.text,
                                state: _stateController.text,
                                profilePic: imageFile == null 
                                    ? null
                                    : File(imageFile!.path));

                            //---------------------------------------calling bloc
                            BlocProvider.of<OnBoardingBloc>(context).add(
                                OnBoardPatientEvent(
                                    token: widget.token, patientform: patient));
                          }
                        },
                        child: BlocBuilder<OnBoardingBloc, OnBoardingState>(
                          builder: (context, state) {
                            if (state is OnBoardingLoading) {
                              return CircularProgressIndicator();
                            } else if (state is OnBordingSuccess) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                //-------------remove keyboard
                                FocusManager.instance.primaryFocus?.unfocus();
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) {
                                    return ScreenLogin();
                                  },
                                ));

                                BlocProvider.of<LoginBloc>(context)
                                    .add(ClearLoginStateEvent());
                              });
                            } else if (state is OnBordingFailure) {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                //------------------
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.error)));

                                BlocProvider.of<OnBoardingBloc>(context)
                                    .add(ClearOnboardingState());
                              });
                            }
                            return Text('Submit');
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
