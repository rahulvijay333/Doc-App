import 'package:appoint_medic/application/AlertSlotTime/add_slot_alert_box_bloc.dart';
import 'package:appoint_medic/application/Auth/authentication_bloc.dart';
import 'package:appoint_medic/application/HomeScreen_today_appointments/bloc/home_today_appointments_bloc.dart';
import 'package:appoint_medic/application/Onboarding/on_boarding_bloc.dart';
import 'package:appoint_medic/application/Payment/payment_bloc.dart';
import 'package:appoint_medic/application/Search/search_bloc.dart';
import 'package:appoint_medic/application/booking/patientSelectSlot/bloc/patient_slot_select_bloc.dart';
import 'package:appoint_medic/application/booking/patientTrackBooking/bloc/booking_tracker_bloc.dart';
import 'package:appoint_medic/application/chat/create_chat/bloc/create_chat_bloc.dart';
import 'package:appoint_medic/application/chat/create_chat_doct/bloc/create_chat_doc_bloc.dart';
import 'package:appoint_medic/application/chat/see_messages/bloc/see_messages_bloc.dart';
import 'package:appoint_medic/application/chat/view_chats/bloc/view_all_chats_bloc.dart';
import 'package:appoint_medic/application/chat/view_chats/search_chat/bloc/search_messages_bloc.dart';
import 'package:appoint_medic/application/create_user/create_user_bloc.dart';
import 'package:appoint_medic/application/create_user/otp_verify/bloc/otp_verify_bloc.dart';
import 'package:appoint_medic/application/doctor%20profile/appointments_section/bloc/home_appointment_today_bloc.dart';
import 'package:appoint_medic/application/doctor%20profile/bloc/doctor_profile_bloc.dart';
import 'package:appoint_medic/application/doctor%20profile/edit_profile/bloc/doctor_profile_edit_bloc.dart';
import 'package:appoint_medic/application/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:appoint_medic/application/login/login_bloc.dart';
import 'package:appoint_medic/application/navbar/navbar_bloc.dart';
import 'package:appoint_medic/application/notifications/bloc/view_notifications_bloc.dart';
import 'package:appoint_medic/application/notifications/notificationStatus_track/bloc/notification_track_bloc.dart';
import 'package:appoint_medic/application/profile/edit_profile/bloc/patient_edit_profile_bloc.dart';
import 'package:appoint_medic/application/profile/profile_details_bloc.dart';
import 'package:appoint_medic/application/searchByCatergory/search_by_category_bloc.dart';
import 'package:appoint_medic/application/slot/appointment_slot_bloc.dart';
import 'package:appoint_medic/application/slot_operations/slot_operations_bloc.dart';
import 'package:appoint_medic/application/speciality/speciality_bloc.dart';
import 'package:appoint_medic/application/view_appointments_doctor/bloc/view_appointments_doct_side_bloc.dart';
import 'package:appoint_medic/application/view_appointments_screen/bloc/view_appointments_patient_side_bloc.dart';
import 'package:appoint_medic/core/color_constants.dart';
import 'package:appoint_medic/domain/db/db_functions.dart';
import 'package:appoint_medic/domain/token_storage/secure_storage.dart';
import 'package:appoint_medic/infrastructure/appointment_slots/slot_service.dart';
import 'package:appoint_medic/infrastructure/auth/auth_service_impl.dart';
import 'package:appoint_medic/infrastructure/booking/booking_service.dart';
import 'package:appoint_medic/infrastructure/chats/chat_service.dart';
import 'package:appoint_medic/infrastructure/doctor%20profile/doctor_profile_service.dart';
import 'package:appoint_medic/infrastructure/forgot_password/forgot_pass_service.dart';
import 'package:appoint_medic/infrastructure/login/loginServiceImpl.dart';
import 'package:appoint_medic/infrastructure/notifications/notification_service.dart';
import 'package:appoint_medic/infrastructure/payment_razorpay/payment_service.dart';
import 'package:appoint_medic/infrastructure/profile/profile_service.dart';
import 'package:appoint_medic/infrastructure/register/register_impl.dart';
import 'package:appoint_medic/infrastructure/search_screen/search_service.dart';
import 'package:appoint_medic/infrastructure/specialities/get_speciality_service.dart';
import 'package:appoint_medic/infrastructure/view_appointments_doctor_service/appointments_fetch_service.dart';
import 'package:appoint_medic/infrastructure/view_appointments_patient_side/view_appointments_pat_service.dart';

import 'package:appoint_medic/presentation/splash/ScreenSplash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

final getIt = GetIt.instance;
void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the locale data for 'en_IN' (English, India)
  await initializeDateFormatting('en_IN', null);
  debugPaintSizeEnabled = false;
  await Hive.initFlutter();
  // if (!Hive.isAdapterRegistered(UserDbAdapter().typeId)) {
  //   Hive.registerAdapter(UserDbAdapter());
  // }

//--------------------------------------------------open hive logged in storage box
  final dbFunction = DbFunctionClass();
  await dbFunction.openDbBox();
  getIt.registerSingleton<SecureStorageService>(SecureStorageService());
  getIt.registerSingleton<PaymentService>(PaymentService());

//----------------------------------------------------------------------------------
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileService profileService = ProfileService();

    final ProfileDetailsBloc profileBloc = ProfileDetailsBloc(profileService);
    final DbFunctionClass db = DbFunctionClass();
    final LoginServiceImpl loginservice = LoginServiceImpl();
    final SharedPrefsAuthServiceImpl sharedpref = SharedPrefsAuthServiceImpl();
    final AuthenticationBloc auth =
        AuthenticationBloc(sharedpref, db, profileBloc);
    final SearchService searchService = SearchService();
    final SpecialityService specialityService = SpecialityService();
    final CreateServiceImpl onboarding = CreateServiceImpl();
    final AppointmentSlotService slotService = AppointmentSlotService();
    final AppointmentSlotBloc slotAuth = AppointmentSlotBloc(slotService);
    final BookingService bookingService = BookingService();
    final ViewAppointmentsPatientSideService patientViewAppService =
        ViewAppointmentsPatientSideService();
    final ViewAppointmentsDoctSideService appointmentsDoctSideService =
        ViewAppointmentsDoctSideService();
    final ChatService chatService = ChatService();
    final DoctorProfileService doctProfService = DoctorProfileService();
    final NotificationService notificationService = NotificationService();
    final PasswordResetService passwordResetService = PasswordResetService();
    final CreateServiceImpl createApiObject = CreateServiceImpl();

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(loginservice, auth, sharedpref, db,
                getIt<SecureStorageService>()),
          ),
          BlocProvider(
            create: (context) =>
                AuthenticationBloc(sharedpref, db, profileBloc),
          ),
          BlocProvider(
            create: (context) => SearchBloc(searchService),
          ),
          BlocProvider(
            create: (context) => SpecialityBloc(specialityService),
          ),
          BlocProvider(
            create: (context) => ProfileDetailsBloc(profileService),
          ),
          BlocProvider(
            create: (context) => SearchByCategoryBloc(searchService),
          ),
          BlocProvider(
            create: (context) => OnBoardingBloc(onboarding),
          ),
          BlocProvider(
            create: (context) => AppointmentSlotBloc(slotService),
          ),
          BlocProvider(
            create: (context) => AddSlotAlertBoxBloc(),
          ),
          BlocProvider(
            create: (context) => NavbarBloc(),
          ),
          BlocProvider(
            create: (context) => SlotOperationsBloc(slotService, slotAuth),
          ),
          BlocProvider(
            create: (context) => PatientSlotSelectBloc(bookingService),
          ),
          BlocProvider(
            create: (context) => BookingTrackerBloc(bookingService),
          ),
          BlocProvider(
            create: (context) => PaymentBloc(),
          ),
          BlocProvider(
            create: (context) =>
                ViewAppointmentsPatientSideBloc(patientViewAppService),
          ),
          BlocProvider(
            create: (context) =>
                HomeTodayAppointmentsBloc(patientViewAppService),
          ),
          BlocProvider(
            create: (context) => ViewAllChatsBloc(chatService),
          ),
          BlocProvider(
            create: (context) => SeeMessagesBloc(chatService),
          ),
          BlocProvider(
            create: (context) =>
                ViewAppointmentsDoctSideBloc(appointmentsDoctSideService),
          ),
          BlocProvider(
            create: (context) => DoctorProfileBloc(doctProfService),
          ),
          BlocProvider(
            create: (context) =>
                HomeAppointmentTodayBloc(appointmentsDoctSideService),
          ),
          BlocProvider(
            create: (context) => DoctorProfileEditBloc(onboarding),
          ),
          BlocProvider(
            create: (context) => PatientEditProfileBloc(onboarding),
          ),
          BlocProvider(
            create: (context) => CreateChatBloc(chatService),
          ),
          BlocProvider(
            create: (context) => CreateChatDocBloc(chatService),
          ),
          BlocProvider(
            create: (context) => OtpVerifyBloc(onboarding), //otp
          ),
          BlocProvider(
            create: (context) => ViewNotificationsBloc(notificationService),
          ),
          BlocProvider(
            create: (context) => NotificationTrackBloc(notificationService),
          ),
          BlocProvider(
            create: (context) => SearchMessagesBloc(chatService),
          ),
          BlocProvider(
            create: (context) => ForgotPasswordBloc(passwordResetService),
          ),
          BlocProvider(
            create: (context) => CreateUserBloc(createApiObject),
          )
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(appBackGround),
            ))),
            home: ScreenSplash()

            //

            ));
  }
}
