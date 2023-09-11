import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../themes/app_theme.dart';

class CheckOutPage extends StatelessWidget {
  final double sumPrice;
  const CheckOutPage({super.key, required this.sumPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBG,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Checkout",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: AppColors.appSecColor, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Container(
              width: 300,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.appBlack, width: 10),
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                color: AppColors.appWhite,
              ),
      
              //color: Colors.amber,
              child: Center(
                child: QrImageView(
                  data:
                      'https://payment.spw.challenge/checkout?price=$sumPrice',
                  version: QrVersions.auto,
                  size: 250.0,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              "Scan & Pay",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: AppColors.appSecColor, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Text(
              "\$${NumberFormat().format(sumPrice)}",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: AppColors.appSecColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
