import 'package:fashion_app/src/view/screen/component/carttab/cart_empty_screen.dart';
import 'package:fashion_app/src/viewmodel/cart_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'component/carttab/cart_scroll.dart';

class CartTab extends StatefulWidget {
  final bool fromBeliLangusng;

  const CartTab({Key? key, this.fromBeliLangusng = false}) : super(key: key);
  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  @override
  void initState() {
    Provider.of<CartViewModel>(context, listen: false).getCartProduk();
    Provider.of<CartViewModel>(context, listen: false).getAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Consumer<CartViewModel>(
          builder: (BuildContext context, value, Widget? child) {
            // return value.listCart.isNotEmpty
            if (value.isLoadingCart) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (value.cartModel!.data!.isEmpty) {
                if (widget.fromBeliLangusng) {
                  return Scaffold(
                    body: Center(
                      child: Text("Produk Kosong"),
                    ),
                  );
                } else {
                  return Center(
                    child: Text("Keranjang Kosong"),
                  );
                }
              } else {
                return CartScroll(
                  listCart: value.cartModel!.data!,
                  fromBeliLangusng: widget.fromBeliLangusng,
                );
              }
            }

            // : CartEmptyScreen();
          },
        ),
      ),
    );
  }
}

class Kosoong extends StatelessWidget {
  const Kosoong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.back();
    Get.back();
    return Container();
  }
}
