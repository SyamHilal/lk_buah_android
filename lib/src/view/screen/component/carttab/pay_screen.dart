import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

import '../../../../viewmodel/cart_viewmodel.dart';

class PayScreen extends StatefulWidget {
  final String url;
  final String orderId;
  const PayScreen({Key? key, required this.url, required this.orderId}) : super(key: key);

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  InAppWebViewController? _webViewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: InAppWebView(
            initialUrlRequest: URLRequest(
              url: Uri.parse(widget.url),
            ),
            onUpdateVisitedHistory:
                (InAppWebViewController controller, Uri? uri, bool? isReload) {
              if (uri.toString().split('/').last == 'payment') {
                Provider.of<CartViewModel>(context, listen: false)
                    .callbackMidtrans(widget.orderId);
                Provider.of<CartViewModel>(context, listen: false)
                    .getTransaksi();
                Get.back();
              }
            },
            initialOptions: InAppWebViewGroupOptions(
              android: AndroidInAppWebViewOptions(useHybridComposition: true),
              ios: IOSInAppWebViewOptions(
                allowsInlineMediaPlayback: true,
              ),
              crossPlatform: InAppWebViewOptions(
                  mediaPlaybackRequiresUserGesture: false,
                  javaScriptEnabled: true,
                  userAgent:
                      'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36'),
            ),
            onWebViewCreated: (InAppWebViewController controller) async {
              _webViewController = controller;
              // getData();
            },
            androidOnPermissionRequest: (InAppWebViewController controller,
                String origin, List<String> resources) async {
              return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT,
              );
            }));
  }
}
