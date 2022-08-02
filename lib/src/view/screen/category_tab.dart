import 'dart:math';

import 'package:fashion_app/main.dart';
import 'package:fashion_app/src/data/service/timezone.dart';
import 'package:fashion_app/src/view/screen/component/carttab/pay_screen.dart';
import 'package:fashion_app/src/viewmodel/cart_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../const/app_colors.dart';
import '../../const/app_font.dart';
import '../../const/endpoint.dart';
import 'component/carttab/checkout.dart';

class CategoryTab extends StatefulWidget {
  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  @override
  void initState() {
    Provider.of<CartViewModel>(context, listen: false).getTransaksi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Transaksi'),
      ),
      body: Consumer<CartViewModel>(
        builder: (context, value, child) {
          if (value.transaksiModel == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (value.transaksiModel!.data!.isEmpty) {
              return Center(
                child: Text('Data Transaksi Kosong'),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () => value.getTransaksi(),
                triggerMode: RefreshIndicatorTriggerMode.anywhere,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: value.transaksiModel!.data!.length,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    var data = value.transaksiModel!.data![index];
                    return InkWell(
                      onTap: () {
                        if (data.statusOrder!.id == 1) {
                          Get.to(CheckoutView(url: data.urlMidtrans!));
                        }
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    data.invoice ?? '',
                                    style: boldTextStyle(size: 12),
                                  ),
                                  5.height,
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.green),
                                    child: Text(
                                      data.statusOrder?.name ?? '',
                                      style: primaryTextStyle(
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              10.height,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Tanggal Transaksi',
                                    style: boldTextStyle(size: 12),
                                  ),
                                  5.height,
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.green),
                                    child: Text(
                                      DateFormat('dd-MMMM-yyyy HH:mm:ss', 'id')
                                          .format(TimeZone.convertToLocal2(
                                                  data.createdAt.toString())
                                              .toLocal()),
                                      style: primaryTextStyle(
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              10.height,
                              if (data.statusOrderId == 5)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Tanggal Diterima',
                                      style: boldTextStyle(size: 12),
                                    ),
                                    5.height,
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.green),
                                      child: Text(
                                       DateFormat('dd-MMMM-yyyy HH:mm:ss', 'id')
                                          .format(TimeZone.convertToLocal2(
                                                  data.updatedAt.toString())
                                              .toLocal()),
                                        style: primaryTextStyle(
                                          size: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              10.height,
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   children: [
                              //     Text(
                              //       'Alamat Pengiriman',
                              //       style: secondaryTextStyle(size: 12),
                              //     ),
                              //     5.height,
                              //     Text(
                              //       "${data.detailAlamat} - ${data.cityName} - ${data.provinceName}",
                              //       style: boldTextStyle(size: 12),
                              //     ),
                              //   ],
                              // ),
                              // 10.height,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'No Resi',
                                    style: secondaryTextStyle(size: 12),
                                  ),
                                  5.height,
                                  Text(
                                    data.noResi ?? '',
                                    style: boldTextStyle(size: 12),
                                  ),
                                ],
                              ),
                              10.height,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Metode Pembayaran',
                                    style: secondaryTextStyle(size: 12),
                                  ),
                                  5.height,
                                  Text(
                                    data.metodePembayaran ?? '',
                                    style: boldTextStyle(size: 12),
                                  ),
                                ],
                              ),
                              10.height,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Kurir',
                                    style: secondaryTextStyle(size: 12),
                                  ),
                                  5.height,
                                  Text(
                                    'JNE',
                                    style: boldTextStyle(size: 12),
                                  ),
                                ],
                              ),
                              10.height,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Total Barang',
                                    style: secondaryTextStyle(size: 12),
                                  ),
                                  5.height,
                                  Text(
                                    "Rp ${formatCurrency.format(data.subtotal)}",
                                    style: boldTextStyle(size: 12),
                                  ),
                                ],
                              ),
                              10.height,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Ongkir',
                                    style: secondaryTextStyle(size: 12),
                                  ),
                                  5.height,
                                  Text(
                                    "Rp ${formatCurrency.format(data.ongkir)}",
                                    style: boldTextStyle(size: 12),
                                  ),
                                ],
                              ),
                              // 10.height,
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   children: [
                              //     Text(
                              //       'Biaya Admin',
                              //       style: secondaryTextStyle(size: 12),
                              //     ),
                              //     5.height,
                              //     Text(
                              //       "Rp ${formatCurrency.format(4000)}",
                              //       style: boldTextStyle(size: 12),
                              //     ),
                              //   ],
                              // ),
                              10.height,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Total Belanja',
                                    style: secondaryTextStyle(size: 12),
                                  ),
                                  5.height,
                                  Text(
                                    "Rp ${formatCurrency.format(data.subtotal! + data.ongkir!)}",
                                    style: boldTextStyle(size: 12),
                                  ),
                                ],
                              ),
                              10.height,
                              Divider(),
                              5.height,
                              Text(
                                'Catatan Pembeli',
                                style: boldTextStyle(size: 12),
                              ),
                              5.height,
                              Text('${data.pesan ?? '-'}'),
                              10.height,
                              Divider(),

                              5.height,
                              Text(
                                'Detail Alamat Pengiriman',
                                style: boldTextStyle(size: 12),
                              ),
                              5.height,
                              Text(
                                  '${data.detailAlamat} ${data.type} ${data.cityName} Provinsi ${data.provinceName}'),
                              10.height,
                              Divider(),
                              5.height,
                              Text(
                                'Produk yang dibeli',
                                style: boldTextStyle(size: 12),
                              ),
                              5.height,
                              ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: data.detailTransaksi!.length,
                                itemBuilder: (c, i) {
                                  var produk = data.detailTransaksi![i];

                                  return ListTile(
                                    leading: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              EndPoint.photoUrl +
                                                  produk.product!.image!,
                                            ),
                                            fit: BoxFit.cover),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                    title: Text(
                                      produk.product?.name ?? '',
                                      style: boldTextStyle(size: 12),
                                    ),
                                    subtitle: Text(
                                      "${produk.qty} x ${formatCurrency.format(produk.product!.price!)}",
                                      style: primaryTextStyle(size: 12),
                                    ),
                                    trailing: Text(
                                      "Rp ${formatCurrency.format(produk.qty! * produk.product!.price!)}",
                                      style: boldTextStyle(size: 12),
                                    ),
                                  );
                                },
                              ),
                              10.height,
                              if (data.statusOrderId != 1 &&
                                  data.statusOrderId != 6 &&
                                  data.statusOrderId != 5)
                                SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: AppColors.primaryColorRed,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        value.confirm(data.id.toString());
                                        // String? size = product.inventory![productViewModel.selectIndex].size;
                                        // String? color = product.inventory![productViewModel.selectIndex].color;
                                      },
                                      child: Text(
                                        "Konfirmasi Barang Diterima",
                                        style: AppFont.medium.copyWith(
                                            fontSize: 17, color: Colors.white),
                                      ),
                                    )),
                              if (data.statusOrderId == 1)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: SizedBox(
                                          width: double.infinity,
                                          height: 30,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.green,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            onPressed: () {
                                              Get.to(PayScreen(
                                                  orderId: data.id.toString(),
                                                  url:
                                                      'https://simulator.sandbox.midtrans.com/bca/va/index'));
                                              // String? size = product.inventory![productViewModel.selectIndex].size;
                                              // String? color = product.inventory![productViewModel.selectIndex].color;
                                            },
                                            child: Text(
                                              "BCA VA",
                                              style: AppFont.medium.copyWith(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            ),
                                          )),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: SizedBox(
                                          width: double.infinity,
                                          height: 30,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.green,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            onPressed: () {
                                              Get.to(PayScreen(
                                                  orderId: data.id.toString(),
                                                  url:
                                                      'https://simulator.sandbox.midtrans.com/bri/va/index'));
                                              // String? size = product.inventory![productViewModel.selectIndex].size;
                                              // String? color = product.inventory![productViewModel.selectIndex].color;
                                            },
                                            child: Text(
                                              "BRI VA",
                                              style: AppFont.medium.copyWith(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            ),
                                          )),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: SizedBox(
                                          width: double.infinity,
                                          height: 30,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.green,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            onPressed: () {
                                              Get.to(PayScreen(
                                                  orderId: data.id.toString(),
                                                  url:
                                                      'https://simulator.sandbox.midtrans.com/bni/va/index'));
                                              // String? size = product.inventory![productViewModel.selectIndex].size;
                                              // String? color = product.inventory![productViewModel.selectIndex].color;
                                            },
                                            child: Text(
                                              "BNI VA",
                                              style: AppFont.medium.copyWith(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              SizedBox(
                                height: 20,
                              ),
                              if (data.statusOrderId == 1)
                                SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: AppColors.primaryColorRed,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        value.cancelOrder(data.id.toString());
                                        // String? size = product.inventory![productViewModel.selectIndex].size;
                                        // String? color = product.inventory![productViewModel.selectIndex].color;
                                      },
                                      child: Text(
                                        "Batalkan Pesanan",
                                        style: AppFont.medium.copyWith(
                                            fontSize: 17, color: Colors.white),
                                      ),
                                    )),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}
