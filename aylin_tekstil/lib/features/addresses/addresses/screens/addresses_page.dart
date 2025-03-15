import 'package:aylin/common/widget/brown_button.dart';
import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/config/theme/custom_colors.dart';
import 'package:aylin/features/addresses/addresses/controller/addresses_contoller.dart';
import 'package:aylin/features/addresses/addresses/model/addresses_model.dart';
import 'package:aylin/features/addresses/update_address/screens/update_address_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aylin/features/addresses/create_address/screens/new_addresses_page.dart';

class AddressesPage extends StatefulWidget {
  const AddressesPage({super.key});

  @override
  State<AddressesPage> createState() => _AddressesPageState();
}

class _AddressesPageState extends State<AddressesPage> {
  final AddressController addressController = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomWidgets.appBar("Adreslerim"),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                final addresses = addressController.getAddresses();
                return ListView.builder(
                  itemCount: addresses.length,
                  itemBuilder: (context, index) {
                    return _buildAddressItem(addresses[index]);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BrownButton(
              title: "+ Yeni Adres Ekle",
              onTap: _navigateToNewAddressPage,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressItem(Address address) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAddressRow(address),
          const SizedBox(height: 10),
          _buildDivider(),
        ],
      ),
    );
  }

  Widget _buildAddressRow(Address address) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAddressIcon(),
        const SizedBox(width: 12.0),
        _buildAddressDetails(address),
        _buildEditButton(address),
      ],
    );
  }

  Widget _buildAddressIcon() {
    return const Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Icon(
        Icons.location_on_outlined,
        color: CustomColors.color,
        size: 24.0,
      ),
    );
  }

  Widget _buildAddressDetails(Address address) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomWidgets.settingBlackText(address.title),
          Text(address.fullAddress),
        ],
      ),
    );
  }

  Widget _buildEditButton(Address address) {
    return IconButton(
      icon: const Icon(
        Icons.edit,
        color: CustomColors.color,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UpdateAddressPage(address: address),
          ),
        );
      },
    );
  }

  Widget _buildDivider() {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: CustomWidgets.customDivider(),
      ),
    );
  }

  void _navigateToNewAddressPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewAddressesPage()),
    );
  }
}
