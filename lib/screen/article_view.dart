import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class ArticleView extends StatefulWidget {

  final String blogUrl;
  ArticleView({this.blogUrl});

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {

  final Completer<WebViewController> _completer = Completer<WebViewController>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //centerTitle: true,
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          title: Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 100.0,),
              // Text('Flutter',style: TextStyle(
              //   color: Colors.black,
              //   fontWeight: FontWeight.bold,
              // ),),
              Text('News',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
              ),
            ],
          ),
        ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

      child: WebView(
          initialUrl: widget.blogUrl,
          onWebViewCreated: ( 
            (WebViewController webViewController){
              _completer.complete(webViewController);
            }
          ),
      ),
      
    ),
    );
  }
}