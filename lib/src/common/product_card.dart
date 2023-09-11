import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:simple_online_shopping/src/common/popup_widget.dart';
import 'package:simple_online_shopping/src/common/product_model.dart';
import 'package:simple_online_shopping/src/features/home/services/home_provider.dart';
import 'package:simple_online_shopping/src/features/product/screens/product_detail_page.dart';
import 'package:simple_online_shopping/themes/app_theme.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String name;
  final double price;

  final ProductModel currentItem;
  const ProductCard({
    super.key,
    required this.currentItem,
    required this.image,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    List<ProductModel> savedItems = context.watch<HomeProvider>().savedItems;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailPage(
                      currentItem: currentItem,
                    )));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                child: SizedBox(
                  height: 140,
                  width: double.infinity,
                  child: Image.network(fit: BoxFit.cover, image),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                          context
                              .read<HomeProvider>()
                              .removeFromSaved(currentItem);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const PopUp(
                                title: 'item is unsaved',
                              );
                            },
                          );
                        }

                        return Future.value(!isLiked);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AppColors.appSecColor),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '\$${NumberFormat().format(price)}',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.appSecColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
