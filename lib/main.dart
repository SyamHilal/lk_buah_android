import 'package:fashion_app/src/data/service/product_service.dart';
import 'package:fashion_app/src/likeButt.dart';
import 'package:fashion_app/src/router/routerr.dart';
import 'package:fashion_app/src/view/screen/dash_board_screen.dart';
import 'package:fashion_app/src/view/screen/login_screen.dart';
import 'package:fashion_app/src/viewmodel/address_viewmodel.dart';
import 'package:fashion_app/src/viewmodel/auth_viemodel.dart';
import 'package:fashion_app/src/viewmodel/bottom_navigate_provider.dart';
import 'package:fashion_app/src/viewmodel/cart_viewmodel.dart';
import 'package:fashion_app/src/viewmodel/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

final formatCurrency =
    NumberFormat.currency(locale: "id_ID", symbol: "", decimalDigits: 0);
void main() async {
  await GetStorage.init();
  initializeDateFormatting('id');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  GetStorage session = GetStorage();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
        ChangeNotifierProvider(create: (_) => AddressViewModel()),
        ChangeNotifierProvider(
            create: (_) => ProductViewModel()..getListProduct()),
        ChangeNotifierProvider(create: (_) => AuthViewModel())
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.deepOrange, accentColor: Colors.deepOrange),
        onGenerateRoute: Routerr.onGenerateRouter,
        home: session.hasData('userID') ? DashBoardScreen() : LoginScreen(),
      ),
    );
  }
}
