import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/features/auth/login/repository/login_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class LoginController extends GetxController {
  final LoginRepository _repository;
  LoginController(this._repository);

  late LoginDelegate delegate;
  var isLoading = false.obs;

  Future<void> loginUser(
      {required String email, required String password}) async {
    isLoading.value = true;
    final result =
        await _repository.loginUser(email: email, password: password);
    if (result.data != null) {
      await getUserInfo(result.data!);
    } else if (result.error != null) {
      CustomWidgets.showSnackBar(message: result.error!.message);
    }
    isLoading.value = false;
  }

  Future<void> getUserInfo(String token) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("token", token);
    final result = await _repository.getUserInfo(token: token);
    if (result.data == true) {
      delegate.notify(true);
    }
  }
}

mixin LoginDelegate {
  void notify(isSuccess);
}