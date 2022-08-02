import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:fashion_app/network/dio_service.dart';
import 'package:fashion_app/src/data/model/address.dart';
import 'package:fashion_app/src/data/model/cart_model/cart_model.dart';
import 'package:fashion_app/src/data/model/city_model/city_model.dart';
import 'package:fashion_app/src/data/model/city_model/result.dart';
import 'package:fashion_app/src/data/model/cost_model/cost_model.dart';
import 'package:fashion_app/src/data/model/cost_model/result.dart';
import 'package:fashion_app/src/data/model/inventory.dart';
import 'package:fashion_app/src/data/model/cart.dart';
import 'package:fashion_app/src/data/model/order.dart';
import 'package:fashion_app/src/data/model/product.dart';
import 'package:fashion_app/src/data/model/province_model/province_model.dart';
import 'package:fashion_app/src/data/model/province_model/result.dart';
import 'package:fashion_app/src/data/model/transaksi_model/transaksi_model.dart';
import 'package:fashion_app/src/view/screen/component/carttab/checkout.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nb_utils/nb_utils.dart';

import '../view/screen/component/dialog_loading.dart';

class CartViewModel extends ChangeNotifier with DioService {
  List<Cart> listCart = [];
  int curr = 1;
  bool isFound = true;
  String message = '';
  double total = 0;
  int productCount = 0;
  int adminConst = 4000;
  int totalWeight = 0;
  int ongkir = 0;
  List<Order> listOrder = [];
  List<Result> listProvince = [];
  ProvinceModel? provinceModel;
  CityModel? cityModel;
  CityData? citySelected;
  CostModel? costModel;
  CostData? costData;
  String courier = "jne";
  int? selectedIndex;

  Result? provinceSelect;
  CartModel? cartModel;
  bool isLoadingCart = true;
  GetStorage session = GetStorage();
  int totalCart = 0;
  TextEditingController controllerAddress = TextEditingController();
  TransaksiModel? transaksiModel;
  TextEditingController controllerCatatan = TextEditingController();

  addToCart(Product product, Inventory inventoryy) {
    productCount = 0;
    if (listCart.isEmpty) {
      listCart.add(
        Cart().copyWith(
          product: product.copyWith(inventory: [inventoryy]),
        ),
      );
      productCount = listCart.length;
      print('EMPTY ${productCount}');
    } else {
      for (int i = 0; i < listCart.length; i++) {
        var index = listCart[i]
            .product
            ?.inventory
            ?.indexWhere((element) => element.id == inventoryy.id);
        debugPrint("INDEX ${index}");
        if (index != -1) {
          if (listCart[i].quantity < inventoryy.stockQuantity!) {
            listCart[i].quantity++;
          } else {
            message = "Số lượng không đủ";
          }
        } else {
          isFound = false;
        }
      }
      if (!isFound) {
        listCart.add(
          Cart().copyWith(
            product: product.copyWith(inventory: [inventoryy]),
          ),
        );
        notifyListeners();
      }

      productCount += listCart.length;
      print('NOT EMPTY ${productCount}');
    }
    calculatePrice();
    notifyListeners();
  }

  void calculatePrice() {
    total = 0;
    listCart.forEach((element) {
      total += element.product!.price! * element.quantity;
    });
    notifyListeners();
  }

  Future increQuantity(Cart order, Inventory inventory) async {
    if (order.quantity < inventory.stockQuantity!) {
      order.quantity++;
    } else {
      message = "Số lượng ko đủ";
    }
    calculatePrice();
    notifyListeners();
  }

  void deceQuanity(Cart order) {
    if (order.quantity > 1) {
      order.quantity--;
    } else {}
    calculatePrice();
    notifyListeners();
  }

  void removeCart(int index) {
    listCart.removeAt(index);
    if (productCount != 0) {
      productCount--;
    }
    calculatePrice();
    notifyListeners();
  }

  void checkOutCart() {
    listOrder.add(Order(
        createAt: "12-10-2012",
        total: total.toString(),
        listItemCart: listCart,
        address: Address(
            userName: "KHOA",
            addressTitle1: "VO VAN VAN",
            addressTitle2: "9384932",
            phone: "97334324"),
        orderNumber: "098765456789"));
  }

  Future<void> getAddress() async {
    if (session.hasData('alamat')) {
      citySelected = CityData.fromJson(jsonDecode(session.read('alamat')));
      provinceSelect = Result.fromJson(jsonDecode(session.read('provinsi')));
      controllerAddress.text = session.read('alamat_detail');
      notifyListeners();
    }
  }

  Future getCartProduk() async {
    cartModel = null;
    isLoadingCart = true;

    final res = await dio
        .post('showkranjang', data: {"user_id": session.read('userID')});
    isLoadingCart = false;
    notifyListeners();
    if (res.statusCode == 201) {
      total = 0;
      totalWeight = 0;
      cartModel = CartModel.fromJson(res.data);
      cartModel!.data!.forEach((element) {
        total += (element.qty! * element.price!);
        totalWeight += (element.weigth! * element.qty!);
      });

      await initial();

      totalCart = total.toInt() + adminConst + ongkir;
      notifyListeners();
    }
  }

  Future updateCart(String productId, int qty) async {
    loadingBuilder();

    final res = await dio
        .post('updatekranjang', data: {"product_id": productId, "qty": qty});
    Get.back();
    if (res.statusCode == 201) {
      toast('Keranjang Berhasil diupdate', gravity: ToastGravity.CENTER);
      getCartProduk();
    } else {
      toast(res.data['message'], gravity: ToastGravity.CENTER);
    }
  }

  Future<void> initial({bool profile = false}) async {
    if (session.hasData('alamat')) {
      provinceSelect = Result.fromJson(jsonDecode(session.read('provinsi')));
      citySelected = CityData.fromJson(jsonDecode(session.read('alamat')));
      controllerAddress.text = session.read('alamat_detail');
      notifyListeners();
      if (!profile) await getCostData('jne');
    }
  }

  Future getProvince() async {
    provinceModel = null;

    if (session.hasData('detail_alamat')) {
      controllerAddress.text = session.read('detail_alamat');
      notifyListeners();
    }

    final res = await dio.get(
      'https://api.rajaongkir.com/starter/province',
    );

    provinceModel = ProvinceModel.fromJson(res.data);
    // listProvince.addAll(province.rajaongkir!.results!);
    notifyListeners();
  }

  void setProviceSleect(Result value) async {
    provinceSelect = value;
    notifyListeners();
    cityModel = null;

    final res = await dio.get('https://api.rajaongkir.com/starter/city',
        queryParameters: {"province": provinceSelect!.provinceId.toString()});
    cityModel = CityModel.fromJson(res.data);
    notifyListeners();
  }

  void setCitySelected(CityData data) async {
    citySelected = data;
    costModel = null;
    notifyListeners();
    final res =
        await dio.post('https://api.rajaongkir.com/starter/cost', data: {
      "weight": totalWeight,
      "courier": courier,
      "origin": 149,
      "destination": citySelected!.cityId,
    });

    costModel = CostModel.fromJson(res.data);
    tapOngkir(costModel!.rajaongkir!.results![0]);
    notifyListeners();
  }

  Future getCostData(String? v) async {
    costModel = null;
    notifyListeners();
    final res =
        await dio.post('https://api.rajaongkir.com/starter/cost', data: {
      "weight": totalWeight,
      "courier": v ?? courier,
      "origin": 149,
      "destination": citySelected!.cityId,
    });

    costModel = CostModel.fromJson(res.data);
    tapOngkir(costModel!.rajaongkir!.results![0]);
    notifyListeners();
  }

  void tapOngkir(CostData data) {
    costData = data;
    ongkir = data.costs![0].cost![0]['value'];
    totalCart = total.toInt() + ongkir + adminConst;
    notifyListeners();
  }

  Future deleteCart(String cartID, bool fromBeli) async {
    loadingBuilder();

    final res = await dio.post('deletekranjang', data: {"id": cartID});
    Get.back();
    if (res.statusCode == 201) {
      if (fromBeli) {
        toast('Produk Berhasil dihapus', gravity: ToastGravity.CENTER);
        getCartProduk();
      } else {
        toast('Keranjang Berhasil Hapus', gravity: ToastGravity.CENTER);
        getCartProduk();
      }
    } else {
      toast(res.data['message'], gravity: ToastGravity.CENTER);
    }
  }

  Future confirm(String idTransaksi) async {
    loadingBuilder();

    final res = await dio.post('confirm', data: {"id": idTransaksi});
    Get.back();
    if (res.statusCode == 201) {
      toast(res.data['message'], gravity: ToastGravity.CENTER);
      getTransaksi();
    } else {
      toast(res.data['message'], gravity: ToastGravity.CENTER);
    }
  }

  Future callbackMidtrans(String idTransaksi) async {
    loadingBuilder();

    final res =
        await dio.post('notificationMidtrans', data: {"id": idTransaksi});
    Get.back();
    if (res.statusCode == 201) {
      toast(res.data['message'], gravity: ToastGravity.CENTER);
      getTransaksi();
    } else {
      toast(res.data['message'], gravity: ToastGravity.CENTER);
    }
  }

  Future cancelOrder(String idTransaksi) async {
    loadingBuilder();

    final res = await dio.post('cancel', data: {"id": idTransaksi});
    Get.back();
    if (res.statusCode == 201) {
      toast(res.data['message'], gravity: ToastGravity.CENTER);
      getTransaksi();
    } else {
      toast(res.data['message'], gravity: ToastGravity.CENTER);
    }
  }

  Future checkOut(bool formBeliLangusng) async {
    if (citySelected == null) {
      toast('Alamat Wajib Disi', gravity: ToastGravity.TOP);
      return;
    }
    loadingBuilder();

    final res = await dio.post('order/simpan', data: {
      "user_id": session.read('userID'),
      "invoice": "TRX-" + DateTime.now().microsecondsSinceEpoch.toString(),
      "subtotal": total,
      "metode_pembayaran": 'midtrans',
      "ongkir": ongkir,
      "biaya_cod": 0,
      "no_hp": session.read('no_hp'),
      "pesan":
          controllerCatatan.text.isEmpty ? '-' : controllerCatatan.text.trim(),
      "city_name": citySelected!.cityName!,
      "city_id": citySelected!.cityId!,
      "province_name": citySelected!.province!,
      "province_id": citySelected!.provinceId,
      "detail_alamat": controllerAddress.text.trim(),
      "type": citySelected!.type!,
      "catatan":
          controllerCatatan.text.isEmpty ? '-' : controllerCatatan.text.trim()
    });
    Get.back();
    if (res.statusCode == 201) {
      getCartProduk();
      if (formBeliLangusng) Get.back();
      toast('Berhasil CheckOut', gravity: ToastGravity.CENTER);

      Get.to(CheckoutView(url: res.data['data']['url_midtrans']));
    } else {
      toast(res.data['message'], gravity: ToastGravity.CENTER);
    }
  }

  Future getTransaksi() async {
    final res = await dio.get("transaksi/${session.read('userID')}");
    transaksiModel = TransaksiModel.fromJson(res.data);
    notifyListeners();
  }
}
