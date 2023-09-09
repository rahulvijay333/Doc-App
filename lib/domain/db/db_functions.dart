import 'dart:developer';

import 'package:appoint_medic/domain/db/db_model.dart';
import 'package:appoint_medic/domain/response_models/admin/admin_response/admin_response.dart';
import 'package:appoint_medic/domain/response_models/doctor_response/doctor_response.dart';
import 'package:appoint_medic/domain/response_models/patient/patient_response/patient_response.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box<UserDb> dbbox;

class DbFunctionClass {
  Future<void> openDbBox() async {
    dbbox = await Hive.openBox<UserDb>(userdbName);
  }

  Future<void> addToDb({required UserDb loggedInUser}) async {
    await dbbox.put(loggedInUser.id, loggedInUser);
  }

  Future<void> clearDb() async {
    
    await dbbox.clear();
  }

  UserDb? getUserDetails(String token) {
    return dbbox.get(token);
  }

  saveToDatabaseFunction(dynamic response) async {
    if (response is AdminResponse) {
      final user = UserDb(
          name: 'admin',
          email: response.user!.email!,
          verifyToken: '',
          role: response.user!.role!,
          token: response.user!.token!,
          id: response.user!.id!);

      await dbbox.put(response.user!.id!, user);
     

      return user;
    } else if (response is PatientResponse) {
      final user = UserDb(
          name: response.user!.name!,
          email: response.user!.email!,
          verifyToken: '',
          role: response.user!.role!,
          token: response.user!.token!,
          id: response.user!.id!);
      await dbbox.put(response.user!.id!, user);
     
      return user;
    } else if (response is DoctorResponse) {
      final user = UserDb(
          name: response.user!.name!,
          email: response.user!.email!,
          verifyToken: '',
          role: response.user!.role!,
          token: response.user!.token!,
          id: response.user!.id!);

      await dbbox.put(response.user!.id!, user);
      
      return user;
    }
  }
}
