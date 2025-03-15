import 'package:aylin/features/auth/forgot_password/screens/forgot_password_screen.dart';
import 'package:aylin/features/auth/verification/model/verification_model.dart';
import 'package:aylin/features/auth/forgot_password/repository/forgot_password_repository.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {
  final ForgotPasswordRepository _repository;
  var verificationCode = VerificationModel("").obs;
  var isLoading = false.obs;

  VerificationController(this._repository);

  void setCode(String code) {
    verificationCode.value = VerificationModel(code);
  }

  Future<void> verifyCode({required String phoneNumber}) async {
    isLoading.value = true;
    
    final result = await _repository.verifyPhoneCode(
      phoneNumber: phoneNumber,
      code: verificationCode.value.code,
    );

    if (result.data == true) {
      Get.to(() => const ForgotPasswordScreen());
    } else if (result.error != null) {
      Get.snackbar("Error", result.error!.message);
    }

    isLoading.value = false;
  }
}
