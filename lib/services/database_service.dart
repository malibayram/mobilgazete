import 'package:mobilturkiyem/model/user_model.dart';

abstract class DatabaseService{
  Future<bool> saveUser(User user);
}