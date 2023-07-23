const baseUrl = 'http://192.168.1.100:4000/api';

class ApiEndPoints {
  //-----------------patient
  static const patientLogin = '$baseUrl/auth/patient/login';
  static const patientRegister = '$baseUrl/auth/patient/register';
  static const patientLogOut = '$baseUrl/auth/patient/logout';
  static const patientGetAllDoctors = '$baseUrl/patient/doctors/all';

  //-----------------doctor
  static const doctorLogin = '$baseUrl/auth/doctor/login';
  static const doctorLogout = '$baseUrl/auth/doctor/logout';
  static const doctorNewUser = '$baseUrl/auth/doctor/register';

  //-----------------------admin
  static const adminLogin = '$baseUrl/auth/admin/login';
  static const adminLogout = '$baseUrl/auth/admin/logout';
}
