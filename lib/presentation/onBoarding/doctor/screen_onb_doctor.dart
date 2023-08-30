import 'dart:developer';
import 'dart:io';

import 'package:appoint_medic/application/Onboarding/on_boarding_bloc.dart';
import 'package:appoint_medic/application/login/login_bloc.dart';
import 'package:appoint_medic/application/speciality/speciality_bloc.dart';
import 'package:appoint_medic/domain/models/onboardingDoctor/doctor_onb_model.dart';
import 'package:appoint_medic/presentation/login/screen_login.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';

class ScreenOnBoardingDoctor extends StatefulWidget {
  final String token;

  const ScreenOnBoardingDoctor({super.key, required this.token});
  @override
  _ScreenOnBoardingDoctorState createState() => _ScreenOnBoardingDoctorState();
}

class _ScreenOnBoardingDoctorState extends State<ScreenOnBoardingDoctor> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _specialityController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _houseNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _serviceController = TextEditingController();
  final TextEditingController _categorycode = TextEditingController();
  final TextEditingController _qualificationController =
      TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  Color profileErrorColor = Colors.transparent;
  Color certificateUploadError = Colors.transparent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<SpecialityBloc>(context).add(DisplaySpecialityHome());
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _genderController.dispose();
    _specialityController.dispose();
    _phoneController.dispose();
    _houseNameController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _serviceController.dispose();
    _qualificationController.dispose();
    super.dispose();
  }

  bool profilePic = false;

//-----------------------------------------------------pdf filepicker
  String _selectedFilePath = '';

  Future<void> _pickPDFFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        setState(() {
          _selectedFilePath = result.files.single.path!;
        });
      }
    } catch (e) {
      print('Error picking PDF file: $e');
    }
  }

  bool isloading = true;
  bool profileError = true;
  File? imageFile;

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

//-----------------------------------------select category alert diologe

  Future<List<String?>> _showCategoryDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        // Replace this with your own category selection UI
        return AlertDialog(
          title: const Text('Select a Category'),
          content: Container(
            height: 200,
            width: 300,
            child: BlocBuilder<SpecialityBloc, SpecialityState>(
              builder: (context, state) {
                if (state is SpecialityLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  );
                } else if (state is SpecialitySucess) {
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).pop([
                              state.specialityList[index].name,
                              state.specialityList[index].id
                            ]);
                          },
                          title: Text(state.specialityList[index].name!),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox();
                      },
                      itemCount: state.specialityList.length);
                } else {
                  return TextButton.icon(
                      onPressed: () {
                        BlocProvider.of<SpecialityBloc>(context)
                            .add(DisplaySpecialityHome());
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reload'));
                }
              },
            ),
          ),
        );
      },
    );
  }
//-------------------------------------------------------------

//---------------------------------------------------select gender

  Future<String?> _showGenderDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Gender'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  Navigator.of(context).pop('male');
                },
                title: const Text('male'),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop('female');
                },
                title: const Text('female'),
              )
            ],
          ),
        );
      },
    );
  }

  List<String> _servicesList = [];

//---

  @override
  Widget build(BuildContext context) {
    List<String> _addServices(String input) {
      List<String> services = input
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();

      _servicesList.addAll(services);
      return _servicesList;
      //_serviceController.clear();
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                //---------------------------------------------------------------logout funtion
                context.read<LoginBloc>().add(ClearLoginStateEvent());

                context.read<OnBoardingBloc>().add(ClearOnboardingState());

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
                  child: Container(
                    width: 150,
                    height: 150,
                    // color: Colors.grey,
                    decoration: BoxDecoration(
                        border: Border.all(color: profileErrorColor),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.5),
                        image: (imageFile != null)
                            ? DecorationImage(
                                fit: BoxFit.cover, image: FileImage(imageFile!))
                            : null),
                    child: (imageFile == null)
                        ? const Icon(
                            Icons.person,
                            size: 50,
                          )
                        : const SizedBox(),
                  ),
                ),
                SizedBox(
                    height: 20,
                    child: profilePic == true
                        ? const Text(
                            'Profile picture required',
                            style: TextStyle(color: Colors.red),
                          )
                        : const Text('')),
                //--------------------------------full name
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
                    String? selectedValue = await _showGenderDialog(context);
                    if (selectedValue != null) {
                      setState(() {
                        _genderController.text = selectedValue;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Speciality required';
                    } else {
                      return null;
                    }
                  },
                  controller: _categoryController,
                  onTap: () async {
                    List<String?> selectedValues =
                        await _showCategoryDialog(context);

                    if (selectedValues.isNotEmpty) {
                      setState(() {
                        // _selectedCategory = selectedValue;
                        _categoryController.text = selectedValues[0]!;
                        _categorycode.text = selectedValues[1]!;
                      });
                    }
                  },
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Select Speciality',
                    border: OutlineInputBorder(),
                  ),
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
                //-------------------------------------service
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'service required';
                    } else {
                      return null;
                    }
                  },
                  controller: _serviceController,
                  decoration: const InputDecoration(
                    labelText: 'Service',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                //------------------------------------qualification
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'qualification required';
                    } else {
                      return null;
                    }
                  },
                  controller: _qualificationController,
                  decoration: const InputDecoration(
                    labelText: 'Qualification',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  //color: Colors.blue.withOpacity(0.2),
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      border: Border.all(color: certificateUploadError),
                      borderRadius: BorderRadius.circular(8)),

                  child: TextButton(
                    onPressed: _pickPDFFile,
                    child: _selectedFilePath.isEmpty
                        ? const Text('Upload Certificate')
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('File selected'),
                              Icon(Icons.file_copy)
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Perform actions on form submission

                      if (imageFile == null) {
                        setState(() {
                          profileErrorColor = Colors.red;
                        });
                      } else {
                        setState(() {
                          profileErrorColor = Colors.transparent;
                        });
                      }
                      if (_selectedFilePath.isEmpty) {
                        setState(() {
                          certificateUploadError = Colors.red;
                        });
                      } else {
                        setState(() {
                          certificateUploadError = Colors.transparent;
                        });
                      }

                      //------------------------------------------------------------qualify values needs to modyfy

                      if (_formkey.currentState!.validate()) {
                        final doctor = DoctorProfileFormData(
                            username: _fullNameController.text,
                            gender: _genderController.text,
                            speciality: _categorycode.text,
                            phone: _phoneController.text,
                            houseName: _houseNameController.text,
                            city: _cityController.text,
                            state: _stateController.text,
                            services: _serviceController.text,
                            qualification: _qualificationController.text,
                            certificate: File(_selectedFilePath),
                            profilePic: imageFile);
                        log('VAlue are present');
                        // log(_addServices(_serviceController.text).toString());
                        log(doctor.toString());

                        context.read<OnBoardingBloc>().add(OnBoardDoctorEvent(
                            token: widget.token, doctorform: doctor));
                      }
                    },
                    child: BlocBuilder<OnBoardingBloc, OnBoardingState>(
                      builder: (context, state) {
                        if (state is OnBoardingLoading) {
                          return CircularProgressIndicator(
                            color: Colors.white,
                          );
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
