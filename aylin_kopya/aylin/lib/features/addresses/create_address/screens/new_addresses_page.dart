import 'package:aylin/common/widget/brown_button.dart';
import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/common/widget/defeault_textfield.dart';
import 'package:aylin/features/addresses/addresses/controller/addresses_contoller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../addresses/model/addresses_model.dart';

class NewAddressesPage extends StatefulWidget {
  const NewAddressesPage({super.key});

  @override
  State<NewAddressesPage> createState() => _NewAddressesPageState();
}

class _NewAddressesPageState extends State<NewAddressesPage> {
  final TextEditingController _addressTitleController = TextEditingController();
  final TextEditingController _fullAddressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();

  final AddressController addressController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomWidgets.appBar("Yeni Adres Ekle"),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: ListView(
                children: [
                  DefaultTextField(
                    title: "Adres Başlığı",
                    controller: _addressTitleController,
                    hintText: "Depo, Mağaza Adı, Şube Adı vb.",
                  ),
                  const SizedBox(height: 10),
                  DefaultTextField(
                      title: "Tam Adres",
                      controller: _fullAddressController,
                      hintText: "Lütfen adresinizi giriniz",
                      maxLines: 5),
                  const SizedBox(height: 10),
                  DefaultTextField(
                    title: "İl",
                    controller: _cityController,
                    hintText: "Lütfen İl Seçiniz",
                  ),
                  const SizedBox(height: 10),
                  DefaultTextField(
                    title: "İlçe",
                    controller: _districtController,
                    hintText: "Lütfen İlçe Seçiniz",
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BrownButton(
              title: "Kaydet",
              onTap: _saveAddress,
            ),
          ),
        ],
      ),
    );
  }

  void _saveAddress() {
    final address = Address(
      title: _addressTitleController.text,
      fullAddress: _fullAddressController.text,
      city: _cityController.text,
      district: _districtController.text,
    );

    addressController.addAddress(address);
    Navigator.pop(context); 
  }
}
