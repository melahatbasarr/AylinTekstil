import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/features/auth/forgot_password/repository/forgot_password_repository.dart';
import 'package:get/get.dart';

final class ForgotPasswordController extends GetxController {
  
  final ForgotPasswordRepository _repository;
  ForgotPasswordDelegate? delegate;

  ForgotPasswordController(this._repository, {this.delegate});

  var isLoading = false.obs;

  Future<void> sendCode({required String phoneNumber}) async {
    isLoading.value = true;
    final result = await _repository.sendCode(phoneNumber: phoneNumber);
    isLoading.value = false;

    if (result.data == true) {
      delegate?.notify(ForgotPasswordResults.codeSent);
    } else {
      CustomWidgets.showSnackBar(message: result.error!.message);
      delegate?.notify(ForgotPasswordResults.failed);
    }
  }

  Future<void> verifyCode(
      {required String phoneNumber, required String code}) async {
    isLoading.value = true;
    final result =
        await _repository.verifyPhoneCode(phoneNumber: phoneNumber, code: code);
    isLoading.value = false;

    if (result.data == true) {
      delegate?.notify(ForgotPasswordResults.codeVerified);
    } else {
      CustomWidgets.showSnackBar(message: result.error!.message);
      delegate?.notify(ForgotPasswordResults.failed);
    }
  }
}

mixin ForgotPasswordDelegate {
  void notify(ForgotPasswordResults result);
}

enum ForgotPasswordResults {
  codeSent,
  codeVerified,
  failed,
}
