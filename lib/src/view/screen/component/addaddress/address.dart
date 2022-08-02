import 'dart:convert';
import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:fashion_app/main.dart';
import 'package:fashion_app/src/data/model/city_model/result.dart';
import 'package:fashion_app/src/data/model/cost_model/result.dart';
import 'package:fashion_app/src/data/model/province_model/result.dart';
import 'package:fashion_app/src/viewmodel/auth_viemodel.dart';
import 'package:fashion_app/src/viewmodel/cart_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../../const/app_colors.dart';
import '../../../../const/app_font.dart';

class AddressViewAdd extends StatefulWidget {
  const AddressViewAdd({Key? key}) : super(key: key);

  @override
  State<AddressViewAdd> createState() => _AddressViewAddState();
}

class _AddressViewAddState extends State<AddressViewAdd> {
  GetStorage session = GetStorage();
  @override
  void initState() {
    Provider.of<CartViewModel>(context, listen: false).getProvince();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(builder: (context, data, _) {
      return DraggableScrollableSheet(
        expand: false,
        minChildSize: 0.6,
        initialChildSize: 0.6,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white),
            child: Consumer<CartViewModel>(builder: (context, data, child) {
              return ListView(
                controller: scrollController,
                physics: const ClampingScrollPhysics(),
                children: [
                  16.height,
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      height: 5.0,
                      width: 70.0,
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                  15.height,
                  ListView(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    children: [
                      if (data.provinceModel == null)
                        DropdownSearch<String>(
                          items: [],
                          onChanged: print,
                          selectedItem: 'Cari Provinsi',
                        ),
                      if (data.provinceModel != null)
                        DropdownSearch<Result>(
                          items: data.provinceModel?.rajaongkir?.results ?? [],
                          onChanged: (value) {
                            data.setProviceSleect(value!);

                            Provider.of<AuthViewModel>(context, listen: false)
                                .getAddress();
                          },
                          selectedItem: data.provinceSelect ?? null,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  hintText: 'Cari Provinsi',
                                  border: OutlineInputBorder())),
                          itemAsString: (item) => item.province!,
                        ),
                      10.height,
                      if (data.cityModel != null)
                        DropdownSearch<CityData>(
                          items: data.cityModel?.rajaongkir?.results ?? [],
                          onChanged: (value) {
                            data.setCitySelected(value!);

                            Provider.of<AuthViewModel>(context, listen: false)
                                .getAddress();
                          },
                          selectedItem: data.citySelected ?? null,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  hintText: 'Cari Kota',
                                  border: OutlineInputBorder())),
                          itemAsString: (item) =>
                              item.type! + " ${item.cityName}",
                        ),
                      10.height,
                      TextField(
                        controller: data.controllerAddress,
                        decoration: InputDecoration(
                            hintText: 'Detail Alamat',
                            border: OutlineInputBorder()),
                      ),
                      10.height,
                    ],
                  ),
                  20.height,
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.primaryColorRed,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                        ),
                        onPressed: () {
                          session.write(
                              'provinsi', jsonEncode(data.provinceSelect));

                          session.write(
                              'alamat', jsonEncode(data.citySelected));
                          log(data.controllerAddress.text.trim());
                          session.write('alamat_detail',
                              data.controllerAddress.text.trim());
                          data.controllerAddress.clear();
                          data.controllerCatatan.clear();
                          Provider.of<AuthViewModel>(context, listen: false)
                              .getAddress();
                          Get.back();
                        },
                        child: Text(
                          "Simpan",
                          style: AppFont.medium
                              .copyWith(fontSize: 17, color: Colors.white),
                        ),
                      )),
                ],
              );
            }),
          );
        },
      );
    });
  }
}
