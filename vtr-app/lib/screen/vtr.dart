import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

import 'package:vtr/networkHandler/NetworkHandler.dart';

class ImagePickerApp extends StatefulWidget {
  final String clothid;

  const ImagePickerApp({@required this.clothid});
  @override
  _ImagePickerAppState createState() => _ImagePickerAppState(clothid);
}

class _ImagePickerAppState extends State<ImagePickerApp> {
  final String clothid;
  NetworkHandler nh = NetworkHandler();
  Dio dio = new Dio();
  File record;
  // Uint8List _base64;
  String name = "VTR";
  String imgString;

  _ImagePickerAppState(this.clothid);
  // Uint8List sendimage() {
  //   return imgString;
  // }

  @override
  void initState() {
    super.initState();
  }

  Future openCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() async {
      if (image != null) {
        record = image;
      }
      // try {
      //   String filename = record.path.split('/').last;
      //   FormData formdata = new FormData.fromMap({
      //     "picture":
      //         await MultipartFile.fromFile(record.path, filename: filename),
      //   });

      //   final res2 = await nh.post("/users", formdata);
      //   String p = res2['path'];
      //   debugPrint("res-2   $p \n $imgString");

      //   final decodedBytes = base64Decode(res2['image']);

      //   name = p;
      //   imgString = decodedBytes;
      //   // s.getimage(imgString);
      // } catch (e) {
      //   print(e);
      // }
    });
  }

  Future takeImg(int val) async {
    // 0 -> gallery
    //  1 -> camera
    // final s = Img();
    var image;
    if (val == 0)
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    else
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      record = image;
    }
    try {
      String filename = record.path.split('/').last;
      FormData formdata = new FormData.fromMap({
        "image": await MultipartFile.fromFile(record.path, filename: filename),
        "clothid": clothid
      });

      final res2 = await nh.post("/userPicPost", formdata);
      // String p = res2['path'];
      // debugPrint("res-2  $imgString");

      // final decodedBytes = base64Decode(res2);

      setState(() {
        if (val == 0)
          name = 'taken from Gallery';
        else
          name = 'taken from Camera';

        imgString = res2;
      });
      // s.getimage(imgString);
    } catch (e) {
      print(e);
    }
  }

  var _currentIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      takeImg(index);
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double uiHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios_new),
          onPressed: () => _sendDataBack(context),
        ),
        title: Text(name),
        backgroundColor: Colors.black45,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          // new BottomNavigationBarItem(
          // Container(
          //   child: FlatButton(
          //     color: Colors.deepOrangeAccent,
          //     child: Text(
          //       "Open Camera",
          //       style: TextStyle(color: Colors.white),
          //     ),
          //     onPressed: () {
          //       takeImg(1);
          //     },
          //   ),
          // )
          // )
          new BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            title: Text(
              "Open Gallery",
              // style: TextStyle(color: Colors.white),
            ),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            title: Text(
              "Open Camera",
              // style: TextStyle(color: Colors.white),
            ),
          ),

          // new BottomNavigationBarItem(
          //   icon: Icon(Icons.mail),
          //   title: Text('Messages'),
          // ),
          // new BottomNavigationBarItem(
          //     icon: Icon(Icons.person), title: Text('Profile'))
        ],
      ),
      body: Center(
        child: Container(
          // height: uiHeight - 100,
          color: Colors.black87,
          // width: 900.0,
          child: imgString == null
              ? Center(
                  child: Padding(
                      padding: new EdgeInsets.all(20.0),
                      child: Text(
                        "Are You Ready for Virtual Trailer Room??.. ${record == null}",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white60, fontSize: 25.0),
                      )))
              : Image.network(
                  nh.get(imgString),
                ),
        ),
      ),
    );

    // Container(
    //   height: uiHeight,
    //   child: Stack(
    //     children: [
    //       Positioned(
    //         left: 0,
    //         right: 0,
    //         child:

    //       ),
    //       Positioned(
    //         bottom: 0,
    //         left: 0,
    //         right: 0,
    //         child: Container(
    //           height: 100,
    //           // color: Colors.pink,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               FlatButton(
    //                 color: Colors.deepOrangeAccent,
    //                 child: Text(
    //                   "Open Camera",
    //                   style: TextStyle(color: Colors.white),
    //                 ),
    //                 onPressed: () {
    //                   takeImg(1);
    //                 },
    //               ),
    //               SizedBox(
    //                 width: 10,
    //               ),
    //               FlatButton(
    //                 color: Colors.limeAccent,
    //                 child: Text(
    //                   "Open Gallery",
    //                   style: TextStyle(color: Colors.black),
    //                 ),
    //                 onPressed: () {
    //                   takeImg(0);
    //                 },
    //               )
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // ));
  }

  void _sendDataBack(BuildContext context) {
    // String textToSendBack = textFieldController.text;
    String s = imgString;
    debugPrint("sending $s");
    Navigator.pop(context, s);
  }

//Backend Part where we store data to firebase

}
