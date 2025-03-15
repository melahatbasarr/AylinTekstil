import 'package:aylin/features/splash/repository/splash_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class SplashController extends GetxController {
  final SplashRepository _repository;
  SplashController(this._repository);

  late SplashDelegate delegate;

  Future<void> getUserInfo() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final bool? isSeen = sharedPreferences.getBool("isOnBoardingSeen");
    if(isSeen == true){
      final result = await _repository.getUserInfo();
      if(result.data == true){
        delegate.notify(SplashResults.navigator);
      } else {
        delegate.notify(SplashResults.login);
      }
    } else {
      delegate.notify(SplashResults.onBoarding);
    }
  }
}

enum SplashResults {
  onBoarding,
  login,
  navigator,
}

mixin SplashDelegate {
  void notify(SplashResults result);
}