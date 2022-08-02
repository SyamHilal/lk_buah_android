import 'package:fashion_app/main.dart';
import 'package:fashion_app/src/const/app_font.dart';
import 'package:fashion_app/src/data/model/cart.dart';
import 'package:fashion_app/src/data/model/cart_model/data_cart.dart';
import 'package:fashion_app/src/viewmodel/cart_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../const/endpoint.dart';

class CartItem extends StatelessWidget {
  final DataCart dataCart;
  final bool fromBeli;
  const CartItem({
    Key? key,
    required this.dataCart, required this.fromBeli,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context, listen: true);
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    EndPoint.photoUrl + dataCart.image!,
                  ),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          dataCart.namaProduk ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: AppFont.semiBold.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      Flexible(
                        child: IconButton(
                            onPressed: () {
                              cartViewModel.deleteCart(dataCart.id.toString(),fromBeli);
                            },
                            icon: Icon(Icons.delete)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Row(
                  //   children: [
                  //     RichText(
                  //       text: TextSpan(children: [
                  //         TextSpan(
                  //             text: "Color: ",
                  //             style: AppFont.regular.copyWith(
                  //                 color: Colors.grey,
                  //                 fontWeight: FontWeight.w400,
                  //                 fontSize: 14),
                  //             children: [
                  //               TextSpan(
                  //                 text: order.product!.inventory![0].color,
                  //                 style: AppFont.regular.copyWith(
                  //                     color: Colors.black,
                  //                     fontWeight: FontWeight.w400,
                  //                     fontSize: 14),
                  //               )
                  //             ]),
                  //       ]),
                  //     ),
                  //     SizedBox(
                  //       width: 5,
                  //     ),
                  //     RichText(
                  //       text: TextSpan(children: [
                  //         TextSpan(
                  //             text: "Size: ",
                  //             style: AppFont.regular.copyWith(
                  //                 color: Colors.grey,
                  //                 fontWeight: FontWeight.w400,
                  //                 fontSize: 14),
                  //             children: [
                  //               TextSpan(
                  //                 text: 'aa',
                  //                 style: AppFont.regular.copyWith(
                  //                     color: Colors.black,
                  //                     fontWeight: FontWeight.w400,
                  //                     fontSize: 14),
                  //               )
                  //             ]),
                  //       ]),
                  //     )
                  //   ],
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 100,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey.withOpacity(.1),
                        ),
                        child: Row(
                          children: [
                            Flexible(
                              child: InkWell(
                                onTap: () {
                                  int qty = dataCart.qty! + 1;
                                  cartViewModel.updateCart(
                                      dataCart.productsId.toString(), qty);
                                  // cartViewModel.increQuantity(
                                  //     order, order.product!.inventory![0]);
                                },
                                child: Icon(
                                  Icons.add,
                                  size: 18,
                                ),
                              ),
                              flex: 1,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              flex: 1,
                              child: Text(dataCart.qty.toString()),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: InkWell(
                                onTap: () {
                                  int qty = dataCart.qty! - 1;
                                  if (qty > 0) {
                                    cartViewModel.updateCart(
                                        dataCart.productsId.toString(), qty);
                                  }

                                  // cartViewModel.deceQuanity(order);
                                },
                                child: Icon(
                                  Icons.remove,
                                  size: 18,
                                ),
                              ),
                              flex: 1,
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Text("${formatCurrency.format(dataCart.price)}")
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
