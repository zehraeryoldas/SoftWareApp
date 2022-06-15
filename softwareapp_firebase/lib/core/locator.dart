import 'package:get_it/get_it.dart';
import 'package:softwareapp_firebase/core/services/authservis.dart';
import 'package:softwareapp_firebase/core/services/navigatorservis.dart';
import 'package:softwareapp_firebase/core/services/sohbetservis.dart';
import 'package:softwareapp_firebase/viewmodel/contacts_model.dart';
import 'package:softwareapp_firebase/viewmodel/main_model.dart';
import 'package:softwareapp_firebase/viewmodel/sign_in_model.dart';
import 'package:softwareapp_firebase/viewmodel/sohbet_model.dart';

GetIt getIt = GetIt.instance;

setupLocators() {
  getIt.registerLazySingleton(() => SohbetServis());
  getIt.registerLazySingleton(() => AuthServis());
  getIt.registerLazySingleton(() => NavigatorService());

  getIt.registerFactory(() => SohbetModel());
  getIt.registerFactory(() => signInModel());
  getIt.registerFactory(() => MainModel());
  getIt.registerFactory(() => ContactsModel());
}
