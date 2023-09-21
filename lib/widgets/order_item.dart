import 'package:agriplant/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'order_product.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.order, this.visibleProducts = 2});

  final Order order;
  final int visibleProducts;

  @override
  Widget build(BuildContext context) {
    final products = order.products.take(visibleProducts).toList();
    final totalPrice = order.products
        .fold(0.0, (previousValue, element) => previousValue + element.price);
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      elevation: 0.1,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Order: ${order.id}",
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  "(${order.products.length} Items)",
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(width: 5),
                Text(
                  "\$${totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...List.generate(products.length, (index) {
              final product = products[index];
              return OrderProduct(order: order, product: product);
            }),
            if (order.products.length > 1) const SizedBox(height: 10),
            if (order.products.length > 1)
              Center(
                  child: TextButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    isScrollControlled: true,
                    builder: (context) {
                      return Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.background,
                        ),
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(14),
                          itemCount: order.products.length,
                          itemBuilder: (context, index) {
                            final product = order.products[index];
                            return OrderProduct(order: order, product: product);
                          },
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(IconlyBold.arrowRight),
                label: const Text("View all"),
              ))
          ],
        ),
      ),
    );
  }
}
