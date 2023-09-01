const baseUrl = 'http://100.26.104.81:4000/api';
// const baseUrl = 'http://192.168.1.100:4000/api';

class ApiEndPoints {
  //-----------------patient - login Auth
  static const patientLogin = '$baseUrl/auth/patient/login';
  static const patientRegister = '$baseUrl/auth/patient/register';
  static const patientLogOut = '$baseUrl/auth/patient/logout';
  static const patientOtpVerify = '$baseUrl/auth/patient/verify';

  static const patientGetAllDoctors = '$baseUrl/patient/doctors/all';
  static const getAllSpecialities = '$baseUrl/doctor/specialities';
  //profile
  static const getProfileDetails = '$baseUrl/patient/profile/details/';
  static const onboardingPatient = '$baseUrl/patient/profile/update';
  static const patientEditProfile = '$baseUrl/patient/profile/update';

  //booking slot
  static const getDoctorAvailableSlotsByIdPatientSide =
      '$baseUrl/patient/doctorprofile/details';
  static const bookingInitiate = '$baseUrl/appointment/initiate';
  static const completeBooking = '$baseUrl/appointment/create';
  //fetch appointments list
  static const getAppointmentList = '$baseUrl/patient/appointments/';

  //chat
  static const getAllChats = '$baseUrl/chat/mychat';
  static const getAllMessages = '$baseUrl/message';
  static const sendNewMessage = '$baseUrl/message';
  static const createNewChat = '$baseUrl/chat/patient/create';

  //-----------------doctor login
  static const doctorLogin = '$baseUrl/auth/doctor/login';
  static const doctorLogout = '$baseUrl/auth/doctor/logout';
  static const doctorNewUser = '$baseUrl/auth/doctor/register';
  static const doctorOtpVerify = '$baseUrl/auth/doctor/verify';

  //profile
  static const getDoctorProfileDetails = '$baseUrl/doctor/profile';
  static const onboardingDoctor = '$baseUrl/doctor/profile/update';
  static const profileEditDoctor = '$baseUrl/doctor/profile/editprofile';
  //slots
  static const getDoctorSlots = '$baseUrl/doctor/slotsByDate';
  static const addDoctorSlots = '$baseUrl/doctor/slots';
  static const deleteSlot = '$baseUrl/doctor/';
  //get appointment list

  static const doctGetAllAppoints = '$baseUrl/doctor/appointments';
  static const doctApproveBooking = '$baseUrl/appointment';
  static const doctCancelBooking = '$baseUrl/appointment';

  //chat

  static const createNewChatByDoc = '$baseUrl/chat/doctor/create';
}
