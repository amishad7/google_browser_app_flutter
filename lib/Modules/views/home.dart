import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Mybrowser extends StatefulWidget {
  Mybrowser({super.key});

  @override
  State<Mybrowser> createState() => _MybrowserState();
}

class _MybrowserState extends State<Mybrowser> {
  InAppWebViewController? inAppWebViewController;
  Connectivity connectivity = Connectivity();
  late PullToRefreshController pullToRefreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pullToRefreshController = PullToRefreshController(
        options: PullToRefreshOptions(
          color: Colors.black,
        ),
        onRefresh: () {
          inAppWebViewController?.reload();
        });
  }

  @override
  Widget build(BuildContext context) {
    Stream<ConnectivityResult> connectivity_stream =
        connectivity.onConnectivityChanged;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              onPressed: () async {
                if (await inAppWebViewController!.canGoForward()) {
                  inAppWebViewController!.goForward();
                }
              },
              child: Icon(Icons.arrow_forward_ios),
            ),
            FloatingActionButton(
              onPressed: () async {
                if (await inAppWebViewController!.canGoBack()) {
                  inAppWebViewController!.goBack();
                }
              },
              child: Icon(Icons.arrow_back_ios),
            ),
            FloatingActionButton(
              onPressed: () {
                inAppWebViewController!.loadUrl(
                    urlRequest:
                        URLRequest(url: Uri.parse("https://www.google.com")));
              },
              child: Icon(Icons.home),
            ),
            FloatingActionButton(
              onPressed: () {
                inAppWebViewController?.reload();
              },
              child: Icon(Icons.refresh),
            ),
          ],
        ),
        body: StreamBuilder(
          stream: connectivity_stream,
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              return (snapshot.data == ConnectivityResult.wifi ||
                      snapshot.data == ConnectivityResult.mobile)
                  ? InAppWebView(
                      pullToRefreshController: pullToRefreshController,
                      initialUrlRequest:
                          URLRequest(url: Uri.parse("https://www.google.com")),
                      onLoadStart: (controller, uri) {
                        setState(() {
                          inAppWebViewController = controller;
                        });
                      },
                      onLoadStop: (controller, uri) {
                        pullToRefreshController.endRefreshing();
                      },
                    )
                  : Center(
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.red,

                          // image: DecorationImage(
                          //   image: AssetImage(
                          //     "lib/App/Utils/Assets/not_connected.jpeg",
                          //   ),
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                      ),
                    );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
