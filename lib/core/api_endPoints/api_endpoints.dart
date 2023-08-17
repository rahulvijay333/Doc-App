const baseUrl = 'http://100.26.104.81:4000/api';

class ApiEndPoints {
  //-----------------patient
  static const patientLogin = '$baseUrl/auth/patient/login';
  static const patientRegister = '$baseUrl/auth/patient/register';
  static const patientLogOut = '$baseUrl/auth/patient/logout';
  static const patientGetAllDoctors = '$baseUrl/patient/doctors/all';
  static const getAllSpecialities = '$baseUrl/doctor/specialities';
  static const getProfileDetails = '$baseUrl/patient/profile/details/';
  static const onboardingPatient = '$baseUrl/patient/profile/update';
   //booking slot
  static const getDoctorAvailableSlotsByIdPatientSide =
      '$baseUrl/patient/doctorprofile/details';

  //-----------------doctor
  static const doctorLogin = '$baseUrl/auth/doctor/login';
  static const doctorLogout = '$baseUrl/auth/doctor/logout';
  static const doctorNewUser = '$baseUrl/auth/doctor/register';
  static const onboardingDoctor = '$baseUrl/doctor/profile/update';
  static const getDoctorSlots = '$baseUrl/doctor/slotsByDate';
  static const addDoctorSlots = '$baseUrl/doctor/slots';
  static const deleteSlot = '$baseUrl/doctor/';

  //-----------------------admin
  static const adminLogin = '$baseUrl/auth/admin/login';
  static const adminLogout = '$baseUrl/auth/admin/logout';
}
