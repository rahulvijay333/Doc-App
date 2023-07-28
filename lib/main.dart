import 'package:appoint_medic/application/Auth/authentication_bloc.dart';
import 'package:appoint_medic/application/Search/search_bloc.dart';
import 'package:appoint_medic/application/login/login_bloc.dart';
import 'package:appoint_medic/application/profile/profile_details_bloc.dart';
import 'package:appoint_medic/application/speciality/speciality_bloc.dart';
import 'package:appoint_medic/domain/db/db_functions.dart';
import 'package:appoint_medic/domain/db/db_model.dart';
import 'package:appoint_medic/infrastructure/auth/auth_service_impl.dart';
import 'package:appoint_medic/infrastructure/login/loginServiceImpl.dart';
import 'package:appoint_medic/infrastructure/profile/profile_service.dart';
import 'package:appoint_medic/infrastructure/search_screen/search_service.dart';
import 'package:appoint_medic/infrastructure/specialities/get_speciality_service.dart';
import 'package:appoint_medic/presentation/doctor/doc_main_screen.dart';
import 'package:appoint_medic/presentation/patient/main_page.dart';
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
    final DbFunctionClass db = DbFunctionClass();
    final LoginServiceImpl loginservice = LoginServiceImpl();
    final SharedPrefsAuthServiceImpl sharedpref = SharedPrefsAuthServiceImpl();
    final AuthenticationBloc auth = AuthenticationBloc(sharedpref, db);
    final SearchService searchService = SearchService();
    final SpecialityService specialityService = SpecialityService();
    final ProfileService profileService = ProfileService();

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(loginservice, auth, sharedpref, db),
          ),
          BlocProvider(
            create: (context) => AuthenticationBloc(sharedpref, db),
          ),
          BlocProvider(
            create: (context) => SearchBloc(searchService),
          ),
          BlocProvider(
            create: (context) => SpecialityBloc(specialityService),
          ),
          BlocProvider(
            create: (context) => ProfileDetailsBloc(profileService),
            child: Container(),
          )
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            // home: ScreenMainPage(userName: 'userName')
            home: ScreenSplash()

            // home: DoctorScreenMain('b'),
            ));
  }
}
