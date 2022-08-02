import 'package:fashion_app/src/viewmodel/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../router/router_path.dart';
import 'component/hometab/cart_product.dart';

class SearchProductView extends StatefulWidget {
  final String keyword;
  const SearchProductView({Key? key, required this.keyword}) : super(key: key);

  @override
  State<SearchProductView> createState() => _SearchProductViewState();
}

class _SearchProductViewState extends State<SearchProductView> {
  @override
  void initState() {
    Provider.of<ProductViewModel>(context, listen: false)
        .getSearchProduct(widget.keyword);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(builder: (context, data, _) {
      return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/image/logo.png',
              width: 20,
              height: 20,
            ),
          ),
          backgroundColor: Colors.deepOrange,
          title: Text('Pencarian Produk'),
          centerTitle: true,
        ),
        body: data.isLoadingSearch
            ? Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : data.searchProduct!.data!.isEmpty
                ? Center(
                    child: Text('Data Tidak ditemukan'),
                  )
                : GridView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.5,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10),
                    itemBuilder: (_, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, DetailProductScreens,
                              arguments: data.searchProduct?.data![index]);
                        },
                        child: CartProduct(
                          index: index,
                          product: data.searchProduct?.data![index],
                        ),
                      );
                    },
                    itemCount: data.searchProduct?.data?.length,
                  ),
      );
    });
  }
}
