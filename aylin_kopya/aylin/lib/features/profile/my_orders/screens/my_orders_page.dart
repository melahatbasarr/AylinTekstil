import 'package:aylin/features/product_detail/screens/track_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aylin/config/theme/custom_colors.dart';
import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/features/basket/controller/basket_controller.dart';
import 'package:aylin/features/basket/model/basket_model.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  final BasketController _basketController = Get.find();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomWidgets.appBar(
          "My Orders",
          backButtonVisibility: true,
        ),
        body: Column(
          children: [
            const TabBar(
              labelColor: CustomColors.color,
              unselectedLabelColor: Colors.grey,
              indicatorColor: CustomColors.color,
              tabs: [
                Tab(text: 'Active'),
                Tab(text: 'Completed'),
                Tab(text: 'Cancelled'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  OrdersTab(
                    status: 'Active',
                    items: _basketController.basketItems
                        .where((item) => item.status == 'Active')
                        .toList(),
                    buttonLabel: 'Track Order',
                  ),
                  OrdersTab(
                    status: 'Completed',
                    items: _basketController.basketItems
                        .where((item) => item.status == 'Completed')
                        .toList(),
                    buttonLabel: 'Leave Review',
                  ),
                  OrdersTab(
                    status: 'Cancelled',
                    items: _basketController.basketItems
                        .where((item) => item.status == 'Cancelled')
                        .toList(),
                    buttonLabel: 'Re-Order',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrdersTab extends StatelessWidget {
  final String status;
  final List<BasketItem> items;
  final String buttonLabel;

  const OrdersTab({
    required this.status,
    required this.items,
    required this.buttonLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: items.length,
      itemBuilder: (context, index) {
        var item = items[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: _buildItemDetails(item, context), 
        );
      },
    );
  }

  Widget _buildItemDetails(BasketItem item, BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: Image.asset(
            item.image,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomWidgets.blackText(item.name),
              const SizedBox(height: 8),
              CustomWidgets.expText(item.color),
              Row(
                children: [
                  Text(
                    item.price,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '| ${item.quantity} Adet',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () {
                            if (status == 'Active') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TrackOrderPage(
                                    item: item,
                                  ),
                                ),
                              );
                            } else if (status == 'Completed') {
                            } else if (status == 'Cancelled') {}
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColors.color,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            buttonLabel,
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
