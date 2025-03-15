import 'package:aylin/features/addresses/addresses/model/addresses_model.dart';
import 'package:aylin/features/addresses/addresses/repository/addresses_repository.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  var addresses = <Address>[].obs;
    final AddressesRepository _repository = AddressesRepository();

  @override
  void onInit() {
    super.onInit();
    _initializeAddresses();
  }

  void _initializeAddresses() {
    var initialAddresses = [
      Address(
        title: "Ev Adresi",
        fullAddress: "İstanbul, Beşiktaş, Barbaros Bulvarı, No:1",
        city: "İstanbul",
        district: "Beşiktaş",
      ),
      Address(
        title: "İş Adresi",
        fullAddress: "İstanbul, Şişli, Mecidiyeköy, No:5",
        city: "İstanbul",
        district: "Şişli",
      ),
      Address(
        title: "Aile Adresi",
        fullAddress: "Ankara, Çankaya, Tunali Hilmi Caddesi, No:20",
        city: "Ankara",
        district: "Çankaya",
      ),
    ];

    addresses.assignAll(initialAddresses);
  }

  void addAddress(Address address) {
    addresses.add(address);
  }

  List<Address> getAddresses() {
    return addresses.toList();
  }

  String getDefaultAddress() {
    if (addresses.isEmpty) {
      return "Kayıtlı adres yok";
    }
    return addresses.first.fullAddress;
  }
}
