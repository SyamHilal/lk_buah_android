import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> loadingBuilder() {
  return Get.dialog(
    Container(
        height: 50,
        width: 50,
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: Colors.orange,
        )),
    barrierDismissible: false,
  );
}
