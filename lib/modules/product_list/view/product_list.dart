import 'package:flutter/material.dart';
import 'package:flutter_cart/modules/product_list/repo/product_repo.dart';
import 'package:flutter_cart/widget/custom_button.dart';
import 'package:flutter_cart/widget/custom_text.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await ProductRepo().getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          customText("text"),
          ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (_, int index) {
                return Row(
                  children: [
                    Image.network("src", height: 48, width: 48),
                    Column(
                      children: [
                        customText("pName"),
                        customText("price"),
                      ],
                    ),
                    customElevatedButton(
                        child: customText("Add"), onPressed: () {}),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
