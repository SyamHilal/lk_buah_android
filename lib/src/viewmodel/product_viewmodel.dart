import 'package:fashion_app/network/dio_service.dart';
import 'package:fashion_app/src/data/model/product.dart';
import 'package:fashion_app/src/data/model/produk_model/produk_model.dart';

import 'package:fashion_app/src/data/service/product_service.dart';
import 'package:fashion_app/src/view/screen/component/dialog_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nb_utils/nb_utils.dart';

class ProductViewModel extends ChangeNotifier with DioService {
  ProductService? productService = ProductService();
  List<Product>? listProduct;
  List<Product>? listRecent = <Product>[];
  bool isLoading = false;
  int? isLikee = 0;
  int selectIndex = 0;
  Product? productt;
  ProdukModel? productModel;
  GetStorage session = GetStorage();

  Future<List<Product>>? getListProduct() {
    isLoading = true;
    notifyListeners();
    listProduct = productService?.listProduct;
    isLoading = false;
    notifyListeners();
  }

  Future likeProduct(Product product) async {
    print(product.title);
    // productt?.isLike = product.isLike;
    // if(productt?.isLike == 0){
    //   productt?.isLike = 1;
    //  notifyListeners();
    // }
    // var a = listProduct?.indexWhere((element) => element.id == product.id);
    // if(a != -1){
    //   listProduct?[a].isLike = isLikee  = 1;
    //
    //   notifyListeners();
    // }
  }

  addRecentView(Product product) {
    if (listRecent!.isEmpty) {
      listRecent?.add(product);
    } else {
      if (listRecent!.contains(product)) {
      } else {
        listRecent?.add(product);
      }
    }
  }

  chooseOption(int index) {
    selectIndex = index;
    notifyListeners();
  }

  Future getProduct() async {
    productModel = null;
    final res = await dio.get('showproduct');
    if (res.statusCode == 201) {
      productModel = ProdukModel.fromJson(res.data);
      notifyListeners();
    }
  }

  ProdukModel? searchProduct;
  bool isLoadingSearch = true;
  Future getSearchProduct(String keyWord) async {
    searchProduct = null;
    isLoadingSearch = true;

    final res = await dio.post('cariproduct', data: {"cari": keyWord});
    isLoadingSearch = false;
    notifyListeners();
    if (res.statusCode == 201) {
      searchProduct = ProdukModel.fromJson(res.data);
      notifyListeners();
    }
  }

  Future addKeranjang(String productId, {bool isCart = true}) async {
    loadingBuilder();

    final res = await dio.post('simpankranjang', data: {
      "products_id": productId,
      "user_id": session.read('userID'),
      "qty": "1"
    });
    Get.back();
    if (res.statusCode == 201) {
      if (isCart)
        toast('Produk Berhasil Masuk Keranjang', gravity: ToastGravity.CENTER);
    } else {
      toast(res.data['message'], gravity: ToastGravity.CENTER);
    }
  }
}
