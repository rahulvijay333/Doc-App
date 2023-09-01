import 'package:appoint_medic/domain/models/onboardingDoctor/doctor_onb_model.dart';
import 'package:appoint_medic/domain/models/onboardingPatient/patient_onb_model.dart';
import 'package:appoint_medic/domain/new_user/new_user.dart';
import 'package:appoint_medic/domain/response_models/onboarding_sucess_response_model/onboarding_sucess_response_model.dart';
import 'package:dio/dio.dart';

import 'response_models/create account/create_new_acount_response/create_new_acount_response.dart';
import 'response_models/signup/new_user_response/new_user_response.dart';

abstract class CreateAccountService {
  Future<(String error, CreateNewAcountResponse? response)> createAccount(
      {required CreateUserModel user, required String userType});

//-------------------------------------------patient profile update
  Future<String> onboardingPatient({
    required FormData patientForm,
  });

//-------------onboarding doctor
  Future<(String error, OnboardingSucessResponseModel? response)>
      onboardingDoctor({
    required String token,
    required DoctorProfileFormData doctorForm,
  });

  Future<String> editProfileDoctor({required FormData doctorForm});
}
