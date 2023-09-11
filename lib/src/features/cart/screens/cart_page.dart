import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_online_shopping/src/common/product_model.dart';
import 'package:simple_online_shopping/src/features/cart/screens/check_out_page.dart';
import 'package:simple_online_shopping/src/features/home/services/home_provider.dart';
import '../../../../themes/app_theme.dart';
import '../cart_in_row.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    List<ProductModel> cartItems = context.watch<HomeProvider>().cartItems;
    double sumPrice = context.watch<HomeProvider>().sumPrice;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Cart',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: AppColors.appSecColor, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            cartItems.length == 0
                ? Column(
                    children: [
                      SizedBox(height: 200),
                      Text(
                        'No items in Cart',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppColors.appSecColor,
                            ),
                      ),
                    ],
                  )
                : Expanded(
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: cartItems.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 2.5 / 1,
                          crossAxisCount: 1,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          var currentItem = cartItems[index];
                          final item = cartItems[index];

                          return SwipeActionCell(
                              key: ObjectKey(item.id.toString()),
                              trailingActions: <SwipeAction>[
                                SwipeAction(
                                    icon: const FaIcon(FontAwesomeIcons.trash),
                                    onTap: (CompletionHandler handler) async {
                                      context
                                          .read<HomeProvider>()
                                          .removeAllFromCart(currentItem);
                                    },
                                    color: Colors.red),
                              ],
                              child: CartInRow(
                                currentItem: currentItem,
                                image: currentItem.imageUrl ?? "",
                                name: currentItem.name ?? "",
                                price: currentItem.price!.toDouble(),
                              ));
                        }),
                  ),
            const SizedBox(height: 16),
            sumPrice == 0
                ? const SizedBox()
                : Row(
                    children: [
                      Text(
                        'Total : \$${NumberFormat().format(sumPrice)}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(
                                color: AppColors.appSecColor,
                                fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CheckOutPage(sumPrice: sumPrice)));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.appMainColor),
                        child: SizedBox(
                          //width: double.infinity,
                          height: 40,
                          child: Center(
                            child: Text(
                              "Checkout",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: AppColors.appWhite,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
