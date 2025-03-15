import 'package:aylin/features/addresses/addresses/model/addresses_model.dart';
import 'package:get/get.dart';

class UpdateAddressController extends GetxController {
  var addresses = <Address>[].obs;

  void updateAddress(Address oldAddress, Address newAddress) {
    final index = addresses.indexOf(oldAddress);
    if (index != -1) {
      addresses[index] = newAddress;
      update();
    }
  }

  void addAddress(Address address) {
    addresses.add(address);
    update();
  }

  List<Address> getAddresses() {
    return addresses;
  }
}
