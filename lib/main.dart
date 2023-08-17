import 'package:appoint_medic/application/AlertSlotTime/add_slot_alert_box_bloc.dart';
import 'package:appoint_medic/application/Auth/authentication_bloc.dart';
import 'package:appoint_medic/application/Onboarding/on_boarding_bloc.dart';
import 'package:appoint_medic/application/Search/search_bloc.dart';
import 'package:appoint_medic/application/booking/patientSelectSlot/bloc/patient_slot_select_bloc.dart';
import 'package:appoint_medic/application/login/login_bloc.dart';
import 'package:appoint_medic/application/navbar/navbar_bloc.dart';
import 'package:appoint_medic/application/profile/profile_details_bloc.dart';
import 'package:appoint_medic/application/searchByCatergory/search_by_category_bloc.dart';
import 'package:appoint_medic/application/slot/appointment_slot_bloc.dart';
import 'package:appoint_medic/application/slot_operations/slot_operations_bloc.dart';
import 'package:appoint_medic/application/speciality/speciality_bloc.dart';
import 'package:appoint_medic/domain/db/db_functions.dart';
import 'package:appoint_medic/domain/db/db_model.dart';
import 'package:appoint_medic/infrastructure/appointment_slots/slot_service.dart';
import 'package:appoint_medic/infrastructure/auth/auth_service_impl.dart';
import 'package:appoint_medic/infrastructure/booking/booking_service.dart';
import 'package:appoint_medic/infrastructure/login/loginServiceImpl.dart';
import 'package:appoint_medic/infrastructure/profile/profile_service.dart';
import 'package:appoint_medic/infrastructure/register/register_impl.dart';
import 'package:appoint_medic/infrastructure/search_screen/search_service.dart';
import 'package:appoint_medic/infrastructure/specialities/get_speciality_service.dart';
import 'package:appoint_medic/presentation/onBoarding/patient/screen_onB_patient.dart';

import 'package:appoint_medic/presentation/splash/ScreenSplash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(UserDbAdapter().typeId)) {
    Hive.registerAdapter(UserDbAdapter());
  }

//--------------------------------------------------open hive logged in storage box
  final dbFunction = DbFunctionClass();
  await dbFunction.openDbBox();
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
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(loginservice, auth, sharedpref, db),
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
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            // home: ScreenMainPage(userName: 'userName')
            home: ScreenSplash()

            // home: ScreenOnBoardingPatient(
            //   token: '',
            // )

            ));
  }
}
