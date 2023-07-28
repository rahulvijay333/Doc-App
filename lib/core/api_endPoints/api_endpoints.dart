const baseUrl = 'http://192.168.1.101:4000/api';

class ApiEndPoints {
  //-----------------patient
  static const patientLogin = '$baseUrl/auth/patient/login';
  static const patientRegister = '$baseUrl/auth/patient/register';
  static const patientLogOut = '$baseUrl/auth/patient/logout';
  static const patientGetAllDoctors = '$baseUrl/patient/doctors/all';
  static const getAllSpecialities = '$baseUrl/doctor/specialities';
  static const getProfileDetails = '$baseUrl/patient/profile/details/';

  //-----------------doctor
  static const doctorLogin = '$baseUrl/auth/doctor/login';
  static const doctorLogout = '$baseUrl/auth/doctor/logout';
  static const doctorNewUser = '$baseUrl/auth/doctor/register';

  //-----------------------admin
  static const adminLogin = '$baseUrl/auth/admin/login';
  static const adminLogout = '$baseUrl/auth/admin/logout';
}
