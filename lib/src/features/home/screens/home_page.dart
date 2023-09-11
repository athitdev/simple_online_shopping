import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_online_shopping/src/features/home/services/home_provider.dart';

import '../../../../themes/app_theme.dart';
import '../../../common/product_card.dart';
import '../../../common/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<ProductModel> homeItems = context.watch<HomeProvider>().homeItems;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'For You',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: AppColors.appSecColor, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: homeItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1 / 1.2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    var currentItem = homeItems[index];
                    return ProductCard(
                      currentItem: currentItem,
                      image: currentItem.imageUrl ?? "",
                      name: currentItem.name ?? "",
                      price: currentItem.price!.toDouble(),

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
