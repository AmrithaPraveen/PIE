import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InAppBrowserPage extends StatefulWidget {
  final String url;
  final String? title;
  final String? subTitle;
  const InAppBrowserPage(
      {required this.url, this.title, this.subTitle, Key? key})
      : super(key: key);

  @override
  State<InAppBrowserPage> createState() => _InAppBrowserPageState();
}

class _InAppBrowserPageState extends State<InAppBrowserPage> {
  double _progress = 0;
  late InAppWebViewController webView;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        leading: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                CupertinoIcons.chevron_back,
                color: Colors.green,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                widget.title ?? "",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              width: 50,
            ),
            Text(
              widget.subTitle ?? "",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        border: const Border(
          bottom: BorderSide.none,
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            InAppWebView(
              initialOptions: options,
              initialUrlRequest: URLRequest(
                  url: WebUri.uri(
                Uri.parse(widget.url),
              )),
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
                // controller.addJavaScriptHandler(
                //     handlerName: 'handlerFoo',
                //     callback: (args) {
                //       // return data to the JavaScript side!
                //       return {'bar': 'bar_value', 'baz': 'baz_value'};
                //     });

                // controller.addJavaScriptHandler(
                //     handlerName: 'handlerFooWithArgs',
                //     callback: (args) {
                //       print(args);
                //       // it will print: [1, true, [bar, 5], {foo: baz}, {bar: bar_value, baz: baz_value}]
                //     });
              },
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                _progress = progress / 100;
                setState(() {});
              },
              // onConsoleMessage: (controller, consoleMessage) {
              //   // log(" console message $consoleMessage");
              //   // it will print: {message: { "bar":"bar_value","baz":"baz_value"}, messageLevel: 1}
              // },
            ),
            _progress < 1
                ? SizedBox(
                    height: 3,
                    child: LinearProgressIndicator(
                      value: _progress,
                      backgroundColor: Colors.green,
                      //  Theme.of(context)
                      //     .colorScheme
                      //     .secondary
                      //     .withOpacity(0.2),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
