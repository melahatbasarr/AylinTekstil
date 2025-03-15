import 'package:aylin/common/model/user_model.dart';

final class UserController {
  static final UserController _instance = UserController._internal();
  UserController._internal();
  factory UserController() => _instance;

  static String name = "";
  static String surname = "";
  static String email = "";
  static int id = 0;

  static void setUserInfo(UserModel model) {
    id = model.id;
    name = model.name;
    surname = model.surname;
    email = model.email;
  }

}