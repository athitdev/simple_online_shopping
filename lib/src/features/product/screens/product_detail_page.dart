import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:simple_online_shopping/src/common/product_model.dart';

import '../../../../themes/app_theme.dart';
import '../../../common/popup_widget.dart';
import '../../home/services/home_provider.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel currentItem;
  const ProductDetailPage({super.key, required this.currentItem});

  @override
  Widget build(BuildContext context) {
    List<ProductModel> savedItems = context.watch<HomeProvider>().savedItems;

    return Scaffold(
      backgroundColor: AppColors.appBG,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.network(
                fit: BoxFit.cover, currentItem.imageUrl.toString()),
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 8,
                child: Text(
                  currentItem.name.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: AppColors.appSecColor),
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  maxLines: 2,
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    LikeButton(
                      isLiked: savedItems.contains(currentItem),
                      onTap: (isLiked) async {
                        if (!savedItems.contains(currentItem)) {
                          context.read<HomeProvider>().addToSaved(currentItem);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const PopUp(
                                isError: false,
                                title: 'item is saved',
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const PopUp(
                                title: 'item is unsaved',
                              );
                            },
                          );
                          context
                              .read<HomeProvider>()
                              .removeFromSaved(currentItem);
                        }
        
                        return Future.value(!isLiked);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '\$${NumberFormat().format(currentItem.price)}',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: AppColors.appSecColor, fontWeight: FontWeight.bold),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                context.read<HomeProvider>().addToCart(currentItem);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const PopUp(
                      isError: false,
                      title: 'item is added into the cart',
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.appMainColor),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: Center(
                  child: Text(
                    "Add to Cart",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.appWhite, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ]),
      ),
    );
  }
}
