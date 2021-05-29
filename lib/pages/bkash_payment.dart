import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../model/payment_request.dart';
import '../utility/js_interface.dart';

class BkashPayment extends StatefulWidget {
  final String amount;
  final String intent;

  const BkashPayment({Key key, @required this.amount, @required this.intent})
      : super(key: key);

  @override
  _BkashPaymentState createState() => _BkashPaymentState();
}

class _BkashPaymentState extends State<BkashPayment> {

  WebViewController _controller;
  JavaScriptInterface _javaScriptInterface;

  bool isLoading = true;
  bool isSuccess = false;
  var paymentRequest = "";

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    var request = PaymentRequest(widget.amount, widget.intent);
    paymentRequest = "{paymentRequest: ${jsonEncode(request)}}";
    print(paymentRequest);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('bKash Checkout')),
      body: Stack(
        children: [
          // Here I patched the default WebView plugin to load
          // local html (along with Javascript and CSS) files from local assets.
          // ref -> https://medium.com/flutter-community/loading-local-assets-in-webview-in-flutter-b95aebd6edad
          WebView(
            initialUrl: 'https://www.flyingbird-bd.com/nagad-payment', // api host link .
            // initialUrl: 'assets/www/checkout_120.html', // api host link .
            javascriptMode: JavascriptMode.unrestricted,
            javascriptChannels: Set.from([
              JavascriptChannel(
                  name: 'onPaymentSuccess',
                  onMessageReceived: (JavascriptMessage message) {
                    // _javaScriptInterface = JavaScriptInterface(context);
                    // _javaScriptInterface.onPaymentSuccess(message.message);
                    print('flutterMessage'+message.message);

                  })
            ]),
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
              _controller.clearCache();
            },
            // onPageFinished: (_) {
            //   // _controller.evaluateJavascript("javascript:callReconfigure($paymentRequest)");
            //   _controller.evaluateJavascript("javascript:clickPayButton()");
            //
            //   setState(() => isLoading = false);
            // },

            onPageFinished: (String url) {
              print('urlFlutter'+ url);

              if(url.contains(new RegExp('https://flyingbird-bd.com/public/shop?', caseSensitive: true))) {
                setState(() {
                  isSuccess = url.contains(
                      new RegExp('status=Success', caseSensitive: true));
                  isSuccess =! url.contains(
                      new RegExp('status=Aborted', caseSensitive: true));
                });
                var data = url.replaceAll("https://flyingbird-bd.com/public/shop?", "").split('&');
                print('data'+url.replaceAll("https://flyingbird-bd.com/public/shop?", "").split('&').toString());

                String status = data[3].replaceAll("status=", "").toString();
                print('status: '+ status);
                Fluttertoast.showToast(msg: status);
              }
              setState(() => isLoading = false);

                // _redirectToStripe(widget.sessionId);
            },
            gestureNavigationEnabled: true,
          ),

          isLoading ? Center(child: CircularProgressIndicator()) : Container(),
        ],
      ),
    );
  }
}
