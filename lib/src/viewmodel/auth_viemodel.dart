import 'dart:convert';
import 'dart:developer';

import 'package:fashion_app/network/dio_service.dart';
import 'package:fashion_app/src/view/screen/component/dialog_loading.dart';
import 'package:fashion_app/src/view/screen/dash_board_screen.dart';
import 'package:fashion_app/src/view/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../data/model/city_model/result.dart';

class AuthViewModel extends ChangeNotifier with DioService {
  bool isLoggedIn = false;
  bool isLoading = false;
  GetStorage session = GetStorage();
  String? username, noHp, email;
  CityData? cityData;
  String? detailAlamat;

  Future login() async {
    isLoggedIn = true;
    notifyListeners();
  }

  Future loginAPi(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      toast('Nomor Hp atau password tidak boleh kosong',
          gravity: ToastGravity.TOP);
      return;
    }
    loadingBuilder();
    final res = await dio.post('login', data: {
      "email": email,
      "password": password,
    });
    Get.back();
    if (res.statusCode == 201) {
      if (res.data['status']) {
        var data = res.data['data']['detail_user'];
        session.write('userID', data['id']);
        session.write('username', data['name']);
        session.write('email', data['email']);
        session.write('role', data['role']);
        session.write('no_hp', data['no_hp']);
        Get.offAll(DashBoardScreen());
      } else {
        toast('Nomor Hp atau password Salah', gravity: ToastGravity.TOP);
      }
    } else {
      toast('Nomor Hp atau password Salah', gravity: ToastGravity.TOP);
    }
  }

  Future register(
      String name, String email, String password, String noHp) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty || noHp.isEmpty) {
      toast('Form tidak boleh kosong', gravity: ToastGravity.TOP);
      return;
    }
    loadingBuilder();
    final res = await dio.post('register', data: {
      "email": email,
      "password": password,
      "name": name,
      "role": 'customer',
      "no_hp": noHp,
    });
    Get.back();
    if (res.statusCode == 201) {
      if (res.data['status']) {
        // var data = res.data['data'];
        // session.write('userID', data['id']);
        // session.write('username', data['name']);
        // session.write('email', data['email']);
        // session.write('role', data['role']);
        // session.write('no_hp', data['no_hp']);

        Get.offAll(LoginScreen());
        toast('Register Berhasil', gravity: ToastGravity.TOP);
      } else {
        toast('Register Gagal', gravity: ToastGravity.TOP);
      }
    } else {
      toast('Register Gagal', gravity: ToastGravity.TOP);
    }
  }

  Future updateUser(String name, String email, String noHp) async {
    if (name.isEmpty || email.isEmpty || noHp.isEmpty) {
      toast('Form tidak boleh kosong', gravity: ToastGravity.TOP);
      return;
    }
    loadingBuilder();
    final res = await dio.post('updateUser', data: {
      "email": email,
      "name": name,
      "no_hp": noHp,
    }, queryParameters: {
      "id": session.read('userID')
    });
    Get.back();
    if (res.statusCode == 200) {
      // if (res.data['success']) {
      var data = res.data['data'];
      session.write('userID', data['id']);
      session.write('username', data['name']);
      session.write('email', data['email']);
      session.write('role', data['role']);
      session.write('no_hp', data['no_hp']);
      getSession();
      Get.back();

      toast('Data Berhasil di update', gravity: ToastGravity.TOP);
      // // } else {
      //   toast('Register Gagal', gravity: ToastGravity.TOP);
      // }
    } else {
      toast('Register Gagal', gravity: ToastGravity.TOP);
    }
  }

  void getSession() {
    username = session.read('username');
    noHp = session.read('no_hp');
    email = session.read('email');
    notifyListeners();
  }

  Future<void> getAddress() async {
    if (session.hasData('alamat')) {
      cityData = CityData.fromJson(jsonDecode(session.read('alamat')));
      detailAlamat = session.read('alamat_detail');
      log(detailAlamat);
      notifyListeners();
    }
  }
}
