import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/config/theme/custom_colors.dart';
import 'package:aylin/features/categories/controller/categories_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final CategoriesController _categoriesController =
      Get.put(CategoriesController());
  final RxInt _selectedHomeModelIndex = 0.obs;
  RangeValues _priceRange = const RangeValues(50, 400);
  String _selectedSortOption = 'Yeni Sezon';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: CustomWidgets.appBar("Filtreleme"),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildHomeModelNames(),
          const SizedBox(height: 20),
          _buildPriceRangeFilter(),
          const SizedBox(height: 20),
          _buildSortOptions(),
          const SizedBox(height: 20),
        ],
      ),
      bottomSheet: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 30),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.textField,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Filtreleri Temizle',
                  style: TextStyle(color: CustomColors.color),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.color,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 0,
                ),
                child: const Text('Uygula',style:TextStyle(color: Colors.white,fontFamily: "Inter"),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeModelNames() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomWidgets.settingBlackText("Kategori"),
        const SizedBox(height: 10),
        SizedBox(
          height: 40,
          child: Obx(
            () => ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categoriesController.categories.length + 1,
              itemBuilder: (context, index) {
                final isAllCategories = index == 0;
                // ignore: non_constant_identifier_names
                final HomeModel = isAllCategories
                    ? null
                    : _categoriesController.categories[index - 1];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedHomeModelIndex.value = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(
                            color: CustomColors.lightGreenText, width: 0.1),
                      ),
                      color: _selectedHomeModelIndex.value == index
                          ? CustomColors.color
                          : Colors.white,
                      elevation: 0,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            isAllCategories ? 'Tümü' : HomeModel!.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _selectedHomeModelIndex.value == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRangeFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomWidgets.settingBlackText("Fiyat Aralığı"),
        const SizedBox(height: 10),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 4.0,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 10.0),
          ),
          child: RangeSlider(
            values: _priceRange,
            min: 50,
            max: 400,
            divisions: 7,
            labels: RangeLabels(
              '${_priceRange.start.toInt()} TL',
              '${_priceRange.end.toInt()} TL',
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _priceRange = values;
              });
            },
            activeColor: CustomColors.color,
            inactiveColor: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(8, (index) {
            int value = 50 + (index * 50);
            return Text('   $value');
          }),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            '${_priceRange.start.toInt()} TL - ${_priceRange.end.toInt()} TL',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildSortOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomWidgets.settingBlackText("Sırala"),
        const SizedBox(height: 10),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildSortOption('Tümü'),
              _buildSortOption('Yeni Sezon'),
              _buildSortOption('En Yüksek Fiyat'),
              _buildSortOption('En Popüler'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSortOption(String option) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSortOption = option;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: const BorderSide(color: CustomColors.color, width: 0.1),
          ),
          color: _selectedSortOption == option
              ? CustomColors.color
              : CustomColors.textField,
          elevation: 0,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                option,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _selectedSortOption == option
                      ? Colors.white
                      : CustomColors.lightGreenText,
                  fontFamily: "Inter",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
