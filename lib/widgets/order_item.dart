import 'dart:math';

import 'package:agriplant/models/order.dart';
import 'package:agriplant/pages/order_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

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
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => OrderDetailsPage(order: order)),
                  );
                },
                behavior: HitTestBehavior.opaque,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 90,
                      width: 90,
                      margin: const EdgeInsets.only(right: 10, bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(product.image),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: theme.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            product.description,
                            style: Theme.of(context).textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$${product.price}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text("Qty: ${Random().nextInt(4) + 1}")
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
            if (order.products.length > 1) const SizedBox(height: 10),
            if (order.products.length > 1)
              Center(
                  child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(IconlyBold.arrowRight),
                label: const Text("View all"),
              ))
          ],
        ),
      ),
    );
  }
}
