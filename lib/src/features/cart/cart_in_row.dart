import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_online_shopping/src/common/product_model.dart';
import 'package:simple_online_shopping/src/features/home/services/home_provider.dart';
import 'package:simple_online_shopping/themes/app_theme.dart';
import 'package:intl/intl.dart';

class CartInRow extends StatelessWidget {
  final String image;
  final String name;
  final double price;
  final ProductModel currentItem;
  const CartInRow({
    super.key,
    required this.currentItem,
    required this.image,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 150,
            width: 150,
            child: Image.network(fit: BoxFit.cover, image),
          ),
        ),
        //const Spacer(),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppColors.appSecColor),
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  maxLines: 2,
                ),
                Text(
                  '\$${NumberFormat().format(price)}',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.appSecColor,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context
                              .read<HomeProvider>()
                              .removeFromCart(currentItem);
                        },
                        child: Container(
                          width: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.appBlack),
                              color: Colors.grey[300],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                              )),
                          child: Center(
                            child: Text(
                              '-',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: AppColors.appSecColor,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          width: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.appBlack),
                            color: AppColors.appWhite,
                          ),
                          child: Center(
                            child: Text(
                              NumberFormat().format(currentItem.number),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: AppColors.appSecColor,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<HomeProvider>().addToCart(currentItem);
                        },
                        child: Container(
                          width: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.appBlack),
                              color: Colors.grey[300],
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                              )),
                          child: Center(
                            child: Text(
                              '+',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: AppColors.appSecColor,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
