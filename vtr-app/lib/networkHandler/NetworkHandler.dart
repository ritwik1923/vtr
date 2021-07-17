import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class NetworkHandler {
  // String baseurl = "http://10.0.2.2:80";
  // String baseurl = "http://127.0.0.1:5000";
  String baseurl = "http://127.0.0.1:5000";
// var url = Uri.parse('https://example.com/whatsit/create');
  Dio dio = new Dio();

  Future post(String url, FormData body) async {
    url = formater(url);

    try {
      Response res2 = await dio.post(url, data: body);
      var s = res2.data;
      print("response vtr: ${res2} ");
      return s;
    } catch (e) {
      print("vtr error: ${e.toString()}");
    }
  }

  String get(String imgString) {
    // url = formater(url);

    try {
      // "http://127.0.0.1:5000/userPicPost?result=${imgString}")
      // return baseurl + '?' + "result=" + imgString;
      return "http://127.0.0.1:5000/userPicPost" + '?' + "result=" + imgString;
    } catch (e) {
      print("vtr error: ${e.toString()}");
    }
  }

  Future getcloths(var url, String id) async {
    url = formater(url);
    FormData formdata = new FormData.fromMap({
      "id": id,
    });
    // getcloths
    Response res2 = await dio.post(url, data: formdata);
    var s = res2.data;
    debugPrint("Sending Response ${s}\n\n res: $res2 \n\n\n\n\n");
    return s['image'];
  }

  Future allData(var url) async {
    // var urls = Uri.parse(baseurl);
    url = formater(url);
    var uri = Uri.parse(url);
    print(uri.host);
    print(uri.port);

    print(url);
    try {
      // var response =
      //     // await http.get(Uri.parse('http://127.0.0.1:5000/getallcloths'));
      //     await http.get(Uri.parse(url));
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      // var s = response.body;
      // print(await http.read('https://example.com/foobar.txt'));
      // await RawSocket.connect("${uri.host}", 5000);
      Response res2 = await dio.get(url);
      var s = res2.data;
      debugPrint("Sending Response ${s}\n\n res: $res2 \n\n\n\n\n");
      return s;
    } catch (e) {
      //Handle all other exceptions
      print("cant get all data $e");
    }
    try {} catch (e) {
      print(e);
    }
  }
  // ...

  String formater(String url) {
    return baseurl + url;
  }

  NetworkImage getImage(String imageName) {
    String url = formater("/uploads//$imageName");
    return NetworkImage(url);
  }
}
