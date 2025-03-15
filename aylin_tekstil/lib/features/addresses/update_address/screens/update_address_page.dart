import 'package:aylin/common/widget/brown_button.dart';
import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/common/widget/defeault_textfield.dart';
import 'package:aylin/features/addresses/addresses/model/addresses_model.dart';
import 'package:aylin/features/addresses/update_address/controller/update_address_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateAddressPage extends StatelessWidget {
  final Address address;

  const UpdateAddressPage({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    final UpdateAddressController controller = Get.find();

    final TextEditingController addressTitleController =
        TextEditingController(text: address.title);
    final TextEditingController fullAddressController =
        TextEditingController(text: address.fullAddress);
    final TextEditingController cityController =
        TextEditingController(text: address.city);
    final TextEditingController districtController =
        TextEditingController(text: address.district);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomWidgets.appBar("Adres Düzenle"),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTextField(
              title: "Adres Başlığı",
              controller: addressTitleController,
              hintText: "Depo, Mağaza Adı, Şube Adı vb.",
            ),
            const SizedBox(height: 10),
            DefaultTextField(
              title: "Tam Adres",
              controller: fullAddressController,
              hintText: "Lütfen adresinizi giriniz",
              maxLines: 5,
            ),
            const SizedBox(height: 10),
            DefaultTextField(
              title: "İl",
              controller: cityController,
              hintText: "Lütfen İl Seçiniz",
            ),
            const SizedBox(height: 10),
            DefaultTextField(
              title: "İlçe",
              controller: districtController,
              hintText: "Lütfen İlçe Seçiniz",
            ),
            const SizedBox(height: 20),
            Center(
              child: BrownButton(
                title: "Kaydet",
                onTap: () {
                  final updatedAddress = Address(
                    title: addressTitleController.text,
                    fullAddress: fullAddressController.text,
                    city: cityController.text,
                    district: districtController.text,
                  );
                  controller.updateAddress(address, updatedAddress);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
