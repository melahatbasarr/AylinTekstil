import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/config/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aylin/features/addresses/addresses/controller/addresses_contoller.dart';
import 'package:aylin/features/addresses/addresses/model/addresses_model.dart';
import 'package:aylin/features/addresses/create_address/screens/new_addresses_page.dart';

class AddressSelectionPage extends StatefulWidget {
  const AddressSelectionPage({super.key});

  @override
  State<AddressSelectionPage> createState() => _AddressSelectionPageState();
}

class _AddressSelectionPageState extends State<AddressSelectionPage> {
  final AddressController addressController = Get.find<AddressController>();
  Address? selectedAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomWidgets.appBar("Teslimat Adresi"),
      body: Obx(
        () {
          final addresses = addressController.getAddresses();
          if (addresses.isEmpty) {
            return const Center(child: Text("Mevcut adres bulunamadı",style: TextStyle(fontFamily: "Inter"),));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: addresses.length,
            itemBuilder: (context, index) {
              final address = addresses[index];
              return AddressTile(
                address: address,
                isSelected: address == selectedAddress,
                onSelect: () => _selectAddress(address),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewAddress,
        backgroundColor: CustomColors.color,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _selectAddress(Address address) {
    setState(() {
      selectedAddress = address;
    });
    Navigator.pop(context, address);
  }

  void _addNewAddress() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NewAddressesPage(),
      ),
    );
  }
}

class AddressTile extends StatelessWidget {
  final Address address;
  final bool isSelected;
  final VoidCallback onSelect;

  const AddressTile({
    required this.address,
    required this.isSelected,
    required this.onSelect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.location_on_outlined,
        color: CustomColors.color,
      ),
      title: Text(address.fullAddress),
      subtitle: Text(address.title),
      trailing: GestureDetector(
        onTap: onSelect,
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? CustomColors.color : Colors.transparent,
            border: Border.all(color: CustomColors.color, width: 2),
          ),
          child: isSelected
              ? const Icon(Icons.check, size: 16, color: Colors.white)
              : null,
        ),
      ),
      onTap: onSelect,
    );
  }
}
