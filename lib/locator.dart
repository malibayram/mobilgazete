import 'package:get_it/get_it.dart';
import 'package:mobilturkiyem/repository/user_repository.dart';
import 'package:mobilturkiyem/services/fake_auth_service.dart';
import 'package:mobilturkiyem/services/firebase_auth_service.dart';
import 'package:mobilturkiyem/services/firestore_db_service.dart';

GetIt locator = GetIt();

void setupLocator(){
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => FakeAuthenticationService());
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => FirestoreDbService());
}