import 'package:fashion_app/src/const/app_font.dart';
import 'package:fashion_app/src/data/model/product.dart';
import 'package:fashion_app/src/data/model/produk_model/datum.dart';
import 'package:fashion_app/src/router/router_path.dart';
import 'package:fashion_app/src/viewmodel/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_product.dart';

class BodyPage extends StatefulWidget {
  @override
  _BodyPageState createState() => _BodyPageState();
}

class _BodyPageState extends State<BodyPage> {
  @override
  Widget build(BuildContext context) {
    ProductViewModel prductVM = Provider.of(context, listen: false);
    double cardWidth = ((MediaQuery.of(context).size.width - 40) / 2);

    return Consumer<ProductViewModel>(builder: (context, data, _) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            buildHeaderBody(
                title: 'Produk kami', description: 'Produk Pilihan Anda'),
            SizedBox(
              height: 10,
            ),
            data.productModel == null
                ? Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : GridView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.57,
                        // mainAxisSpacing: 10,
                        crossAxisSpacing: 10),
                    itemBuilder: (_, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, DetailProductScreens,
                              arguments: data.productModel?.data![index]);
                        },
                        child: CartProduct(
                          index: index,
                          product: data.productModel?.data![index],
                        ),
                      );
                    },
                    itemCount: data.productModel?.data?.length,
                  ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      );
    });
  }

  Widget buildHeaderBody({required String title, required String description}) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: AppFont.bold.copyWith(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              description,
              style: AppFont.regular.copyWith(
                fontSize: 13,
                color: Colors.grey,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        Spacer(),
        // Text(
        //   'View all',
        //   style: AppFont.regular.copyWith(
        //     fontSize: 13,
        //     color: Colors.black,
        //     fontWeight: FontWeight.normal,
        //   ),
        // ),
      ],
    );
  }
}
