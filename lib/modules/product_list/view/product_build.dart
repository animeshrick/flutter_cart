import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/extension/spacing.dart';
import 'package:flutter_cart/widget/custom_button.dart';
import 'package:flutter_cart/widget/custom_text.dart';

import '../model/product.dart';
class ProductBuild extends StatelessWidget {

  final List<Product>? prdList;

  const ProductBuild({super.key, required this.prdList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: prdList?.length??0,
          padding: const EdgeInsets.symmetric(
              vertical: 0, horizontal: 15),
          itemBuilder: (_, int index) {
            Product? product = prdList?.elementAt(index);
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.network("https://res.retailershakti.com/incom/images/product/thumb/${product?.productImage??" "}", height: 48, width: 48),
                    // const Icon(Icons.ice_skating, size: 20),
                    15.pw,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(product?.displayName??""),
                        5.ph,
                        customText(product?.offerPrice.toString()??""),
                      ],
                    ),
                  ],
                ),
                customElevatedButton(
                    color: Colors.green,
                    radius: 8,
                    child: customText("Add", color: Colors.white),
                    onPressed: () {}),
              ],
            );
          }),
    );
  }
}
