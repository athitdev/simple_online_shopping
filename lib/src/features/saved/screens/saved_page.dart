import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_online_shopping/src/common/product_model.dart';

import 'package:simple_online_shopping/src/features/home/services/home_provider.dart';

import '../../../../themes/app_theme.dart';
import '../../../common/product_card.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  Widget build(BuildContext context) {
    List<ProductModel> savedItems = context.watch<HomeProvider>().savedItems;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Saved',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: AppColors.appSecColor, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            savedItems.length == 0
                ? Column(
                    children: [
                      SizedBox(height: 200),
                      Text(
                        'No items is saved',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppColors.appSecColor,
                            ),
                      ),
                    ],
                  )
                : Expanded(
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: savedItems.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1 / 1.2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          var savedCurrentItem = savedItems[index];
                          return ProductCard(
                            currentItem: savedCurrentItem,
                            image: savedCurrentItem.imageUrl ?? "",
                            name: savedCurrentItem.name ?? "",
                            price: savedCurrentItem.price!.toDouble(),

                            // isLike: true,
                          );
                        }),
                  ),
          ],
        ),
      ),
    );
  }
}
