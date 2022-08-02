import 'dart:convert';

import 'package:fashion_app/src/const/app_font.dart';
import 'package:fashion_app/src/data/model/city_model/result.dart';
import 'package:fashion_app/src/router/router_path.dart';
import 'package:fashion_app/src/view/screen/choice_address_screen.dart';
import 'package:fashion_app/src/view/screen/component/addaddress/address.dart';
import 'package:fashion_app/src/view/screen/edit_user.dart';
import 'package:fashion_app/src/view/screen/login_screen.dart';
import 'package:fashion_app/src/viewmodel/auth_viemodel.dart';
import 'package:fashion_app/src/viewmodel/cart_viewmodel.dart';
import 'package:fashion_app/src/viewmodel/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class PersonalTab extends StatefulWidget {
  @override
  _PersonalTabState createState() => _PersonalTabState();
}

class _PersonalTabState extends State<PersonalTab> {
  Map<String, String> listInfomation = {
    'My orders': 'Already have 12 orders',
    'Shipping addresses': '3 address',
    'Payment methods': 'Visa ',
    'My reviews': 'Reviews for 4 items',
    'Recent View': 'Reviews for 4 items',
  };

  @override
  void initState() {
    Provider.of<AuthViewModel>(context, listen: false).getSession();
    Provider.of<AuthViewModel>(context, listen: false).getAddress();
    Provider.of<CartViewModel>(context, listen: false).initial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var productVM = Provider.of<ProductViewModel>(context, listen: false);
    GetStorage sesion = GetStorage();
    // sesion.remove('alamat');

    return Consumer<AuthViewModel>(builder: (context, data, _) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://png.pngtree.com/png-vector/20190223/ourmid/pngtree-vector-avatar-icon-png-image_695765.jpg'),
                        fit: BoxFit.cover),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sesion.read('username'),
                        style: AppFont.semiBold.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        sesion.read('email'),
                        style: AppFont.medium.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextButton(
                        onPressed: () => Get.to(EditUserView()),
                        child: Text(
                          'Edit',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Expanded(
                child: ListView(
              children: [
                ListTile(
                  //           contentPadding: EdgeInsets.all(0.0),
                  title: Text(
                    'Nama',
                    style: AppFont.semiBold
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  subtitle: Text(
                    data.username ?? '',
                    style: AppFont.regular.copyWith(
                        fontWeight: FontWeight.w100,
                        fontSize: 13,
                        color: Colors.grey),
                  ),
                  // trailing: IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(
                  //     Icons.arrow_forward_ios,
                  //     size: 18,
                  //     color: Colors.grey,
                  //   ),
                  // ),
                ),
                ListTile(
                  //           contentPadding: EdgeInsets.all(0.0),
                  title: Text(
                    'email',
                    style: AppFont.semiBold
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  subtitle: Text(
                    data.email ?? '',
                    style: AppFont.regular.copyWith(
                        fontWeight: FontWeight.w100,
                        fontSize: 13,
                        color: Colors.grey),
                  ),
                  // trailing: IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(
                  //     Icons.arrow_forward_ios,
                  //     size: 18,
                  //     color: Colors.grey,
                  //   ),
                  // ),
                ),
                ListTile(
                  //           contentPadding: EdgeInsets.all(0.0),
                  title: Text(
                    'No HP',
                    style: AppFont.semiBold
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  subtitle: Text(
                    data.noHp ?? '',
                    style: AppFont.regular.copyWith(
                        fontWeight: FontWeight.w100,
                        fontSize: 13,
                        color: Colors.grey),
                  ),
                  // trailing: IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(
                  //     Icons.arrow_forward_ios,
                  //     size: 18,
                  //     color: Colors.grey,
                  //   ),
                  // ),
                ),
                ListTile(
                  //           contentPadding: EdgeInsets.all(0.0),
                  title: Text(
                    'Level Pengguna',
                    style: AppFont.semiBold
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  subtitle: Text(
                    sesion.read('role'),
                    style: AppFont.regular.copyWith(
                        fontWeight: FontWeight.w100,
                        fontSize: 13,
                        color: Colors.grey),
                  ),
                  // trailing: IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(
                  //     Icons.arrow_forward_ios,
                  //     size: 18,
                  //     color: Colors.grey,
                  //   ),
                  // ),
                ),
                ListTile(
                  onTap: () => showBottomSheeet(context),
                  title: Text(
                    'Alamat Saya',
                    style: AppFont.semiBold
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  subtitle: Text(
                    data.cityData != null
                        ? data.detailAlamat.toString() +
                            " ${data.cityData!.type} ${data.cityData!.cityName} ${data.cityData!.province}"
                        : '-',
                    style: AppFont.regular.copyWith(
                        fontWeight: FontWeight.w100,
                        fontSize: 13,
                        color: Colors.grey),
                  ),
                  // trailing: IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(
                  //     Icons.arrow_forward_ios,
                  //     size: 18,
                  //     color: Colors.grey,
                  //   ),
                  // ),
                ),
                ListTile(
                  //           contentPadding: EdgeInsets.all(0.0),
                  onTap: () {
                    sesion.remove('userID');
                    sesion.remove('email');
                    sesion.remove('username');
                    sesion.remove('role');
                    sesion.remove('alamat_detail');
                    sesion.remove('provinsi');
                    sesion.remove('alamat');
                    Provider.of<CartViewModel>(context, listen: false)
                        .citySelected = null;
                    Provider.of<CartViewModel>(context, listen: false).ongkir =
                        0;
                    Provider.of<CartViewModel>(context, listen: false)
                        .totalWeight = 0;
                    Provider.of<CartViewModel>(context, listen: false).total =
                        0;
                    Provider.of<CartViewModel>(context, listen: false)
                        .provinceSelect = null;
                    Provider.of<CartViewModel>(context, listen: false)
                        .controllerCatatan
                        .clear();
                    data.cityData = null;
                    data.detailAlamat = null;

                    Get.offAll(LoginScreen());
                  },
                  title: Text(
                    'Keluar',
                    style: AppFont.semiBold
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  subtitle: Text(
                    'Keluar Dari Aplikasi',
                    style: AppFont.regular.copyWith(
                        fontWeight: FontWeight.w100,
                        fontSize: 13,
                        color: Colors.grey),
                  ),
                  // trailing: IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(
                  //     Icons.arrow_forward_ios,
                  //     size: 18,
                  //     color: Colors.grey,
                  //   ),
                  // ),
                ),
              ],
            ))
            // Expanded(
            //   child: ListView.separated(
            //     shrinkWrap: true,
            //     itemCount: listInfomation.length,
            //     separatorBuilder: (BuildContext context, int index) => Divider(),
            //     itemBuilder: (BuildContext context, int index) {
            //       var title = listInfomation.keys.elementAt(index);
            //       var subtitle = listInfomation.values.elementAt(index);
            //       return InkWell(
            //         onTap: () {
            //           switch (index) {
            //             case 0:
            //               Navigator.pushNamed(context, MyOrderScreens);
            //               break;
            //             case 1:
            //               Navigator.pushNamed(context, ChoiceAddressScreens);
            //               break;
            //             case 4:
            //               Navigator.pushNamed(context, RecentViewScreens,
            //                   arguments: productVM.listRecent);
            //               break;
            //           }
            //         },
            //         child: ListTile(
            //           contentPadding: EdgeInsets.all(0.0),
            //           title: Text(
            //             title,
            //             style: AppFont.semiBold
            //                 .copyWith(fontWeight: FontWeight.bold, fontSize: 17),
            //           ),
            //           subtitle: Text(
            //             subtitle,
            //             style: AppFont.regular.copyWith(
            //                 fontWeight: FontWeight.w100,
            //                 fontSize: 13,
            //                 color: Colors.grey),
            //           ),
            //           trailing: IconButton(
            //             onPressed: () {},
            //             icon: Icon(
            //               Icons.arrow_forward_ios,
            //               size: 18,
            //               color: Colors.grey,
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // )
          ],
        ),
      );
    });
  }
}

Future showBottomSheeet(BuildContext context) {
  return Get.bottomSheet(const AddressViewAdd(),
      isScrollControlled: true, elevation: 3);
}
