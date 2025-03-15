import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/features/auth/register/repository/register_repository.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final RegisterRepository _repository;
  RegisterController(this._repository);

  late RegisterDelegate delegate;
  var isLoading = false.obs;

  Future<void> registerUser({
    required String companyName,
    required String taxNumber,
    required String taxOffice,
    required String city,
    required String district,
    required String address,
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    isLoading.value = true;
    try {
      final result = await _repository.registerUser(
        companyName: companyName,
        taxNumber: taxNumber,
        taxOffice: taxOffice,
        city: city,
        district: district,
        address: address,
        name: name,
        email: email,
        phone: phone,
        password: password,
      );

      if (result.data != null) {
        if (result.error != null) {
          CustomWidgets.showSnackBar(message: result.error!.message);
        } else {
          CustomWidgets.showSnackBar(message: "Kayıt başarılı!");
        }
        delegate.notify(result.error == null);
      } else {
        String errorMessage = result.error?.message ?? "Bilinmeyen bir hata oluştu.";
        CustomWidgets.showSnackBar(message: errorMessage);
        delegate.notify(false);
      }
    } catch (e) {
      CustomWidgets.showSnackBar(message: "Kayıt işlemi sırasında bir hata oluştu: ${e.toString()}");
      delegate.notify(false);
    } finally {
      isLoading.value = false;
    }
  }
}

mixin RegisterDelegate {
  void notify(bool isSuccess);
}
