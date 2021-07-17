import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vtr/constrant.dart';
import 'package:vtr/networkHandler/NetworkHandler.dart';
import 'package:vtr/screen/MainWindow.dart';
import 'package:vtr/screen/RatioButtom.dart';
import 'package:vtr/screen/SilverHeader.dart';
import 'dart:convert';
import 'package:vtr/screen/vtr.dart';
import 'package:intl/intl.dart'; // currency converter
import 'dart:math' as math;

void print(Map<String, dynamic> items) => debugPrint('$items');

class Index_Cloth extends StatefulWidget {
  Map<String, dynamic> item;
  // In the constructor, require a Todo.
  Index_Cloth({Key key, @required this.item}) : super(key: key);
  @override
  _Index_ClothState createState() => _Index_ClothState(item);
}

class _Index_ClothState extends State<Index_Cloth> {
  NetworkHandler nh = NetworkHandler();
  // final v = Img();
  final oCcy = new NumberFormat("#,##0.00", "en_US");
  final controller = PageController(viewportFraction: 0.8);
  bool _switchValue = false;
  Map<String, dynamic> items;
  _Index_ClothState(this.items);
  Uint8List img;
  Uint8List stock;
  List<String> images = [];
  int p = 0;
  int len = 10;
  int sizeSelected = 0;

  var SizeSelectState = [true, false, false, false, false, false, false];
  var Size = ['S', 'M', 'L', "XL", "XXL", "XXXL", "XXXXL"];
  @override
  void initState() {
    images.add("http://127.0.0.1:5000/getcloths?id=${items['_id']}");
    super.initState();
  }

  // List<Uint8List> images;
  Future vtr(BuildContext context, String clothid) async {
    final pic = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new ImagePickerApp(
                  clothid: clothid,
                )));
    _switchValue = false;
    debugPrint("pic: ${pic}");
    if (pic != null)
      setState(() {
        images.add(nh.get(pic));
        ++p;
        for (int i = 0; i < 2; i++) {
          debugPrint("$i: ${images[i]}");
        }
      });
  }

  // In the constructor, require a Todo.
  @override
  Widget build(BuildContext context) {
    // Uint8List img = base64Decode(items['image']);
    double uiHeight = MediaQuery.of(context).size.height;
    double uiWidth = MediaQuery.of(context).size.width;
    double cardHeight = 174;
    double cardWidth = uiWidth;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: () {},
        //   isExtended: true,

        //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        //   // icon: Icon(Icons.supervised_user_circle),
        //   label: Text('ADD TO CART'),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

        // appBar: AppBar(title: Text("${items["path"]}")),
        body: Container(
          // padding: EdgeInsets.all(8),
          // margin: EdgeInsets.all(8),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(

                  // <-- app bar for logo
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black54,
                    ),
                    tooltip: 'Show Snackbar',
                    onPressed: () {
                      Navigator.pop(context);

                      // ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(content: Text('This is a snackbar')));
                    },
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.navigate_next),
                      tooltip: 'Go to the next page',
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                            return Scaffold(
                              appBar: AppBar(
                                title: const Text('Next page'),
                              ),
                              body: const Center(
                                child: Text(
                                  'This is the next page',
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                            );
                          },
                        ));
                      },
                    ),
                  ],
                  expandedHeight: ((uiHeight * 5) / 10),
                  floating: false,
                  pinned: false,
                  elevation: 0.0,
                  backgroundColor: Colors.black12,
                  brightness: Brightness.light,
                  flexibleSpace: SafeArea(
                      child: FlexibleSpaceBar(
                    background: Stack(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          top: 0,
                          child:
                              // SizedBox(height: 16),
                              SizedBox(
                            height: 300,
                            child: PageView(
                              controller: controller,
                              children: List.generate(
                                  images.length,
                                  (index) => Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 4),
                                        child: Container(
                                          height: 280,
                                          child: Center(
                                            child:

                                                // Text("${images[index]}"),
                                                Image.network(
                                              images[index],
                                              fit: BoxFit.fill,
                                              // height: 145,
                                            ),
                                          ),
                                        ),
                                      )),
                            ),
                          ),
                          // Image.asset(
                          //   'images/men.jpg',
                          //   fit: BoxFit.fitHeight,
                          //   // width: 120,
                          //   height: uiHeight / 2,
                          // ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: IconButton(
                            onPressed: () {
                              // TODO: add counter on shop cart icon
                            },
                            icon: Icon(Icons.shopping_basket_outlined),
                          ),
                        ),
                        Positioned(
                            bottom: 10,
                            right: 0,
                            left: 0,
                            // left: uiWidth / 2 - len * 10,
                            child: Container(
                                // color: Colors.pink,
                                child: Center(
                              child: SmoothPageIndicator(
                                controller: controller, // PageController
                                count: images.length,

                                // forcing the indicator to use a specific direction
                                // textDirection: TextDirection.LTR,
                                effect: ScrollingDotsEffect(
                                  activeStrokeWidth: 1.6,
                                  activeDotScale: 1.3,
                                  radius: 8,
                                  spacing: 8,
                                  // spacing: 4.0,
                                  // radius: 2.0,
                                  dotWidth: 8.0,
                                  dotHeight: 8.0,
                                  dotColor: Colors.black38,
                                  paintStyle: PaintingStyle.fill,
                                  // strokeWidth: 2,
                                  activeDotColor: Colors.black54,
                                ),
                                // WormEffect(),
                              ),
                            )

                                // SmoothPageIndicator(
                                //   controller: controller,
                                //   count: 6,
                                //   axisDirection: Axis.horizontal,
                                //   effect: SlideEffect(
                                //     scrolling Dots:
                                //       spacing: 8.0,
                                //       radius: 2.0,
                                //       dotWidth: 24.0,
                                //       dotHeight: 16.0,
                                //       paintStyle: PaintingStyle.stroke,
                                //       strokeWidth: 1.5,
                                //       dotColor: Colors.grey,
                                //       activeDotColor: Colors.indigo),
                                // ),

                                )),
                      ],
                    ),
                  ))),
              SliverList(
                // itemExtent: math.max(uiHeight / 10, 150),
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      // height: uiHeight / 2,
                      color: Colors.black12,
                      child: Card(
                        margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                        // color: Colors.amber,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          // mainAxisAlignment: MainAxisAlignment.,
                          children: [
                            // Container(height: uiHeight / 4),
                            // Container(height: uiHeight / 4),
                            // Container(height: uiHeight / 4),
// description selecter

                            Container(
                              // height: math.max(uiHeight / 6, 80),
                              height: 90,
                              // margin: EdgeInsets.all(16),
                              padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                              child: Stack(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Positioned(
                                    left: 0,
                                    bottom: 10,
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      // color: Colors.green[300],
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        textBaseline: TextBaseline.ideographic,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Container(
                                              // color: Colors.black26,
                                              child: Text(
                                                "${items['brand']}",
                                                // 'levis\'s',
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  // fontWeight: FontWeight.bold,
                                                  color: Colors.black54,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            // color: Colors.black26,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.baseline,
                                              textBaseline:
                                                  TextBaseline.ideographic,
                                              // mainAxisAlignment: MainAxisAlignment.b,
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Text(
                                                    '₹${items['price']}',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      // color: Colors.white70,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Text(
                                                    '₹${items['price'] * (100 + items['discount']) / 100}',
                                                    style: TextStyle(
                                                      textBaseline: TextBaseline
                                                          .ideographic,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Text(
                                                    '(${items['discount']}% off)',
                                                    style: TextStyle(
                                                      textBaseline: TextBaseline
                                                          .ideographic,
                                                      fontSize: 15,
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.red,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 10,
                                    child: Container(
                                      // color: Colors.amber,
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  // TODO: add counter on shop cart icon
                                                },
                                                icon: Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                  size: 40,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1,
                                              ),
                                              Text(
                                                "${items['price'] % 11}K",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  // fontWeight: FontWeight.bold,
                                                  color: Colors.black54,
                                                ),
                                              )
                                            ],
                                          ),
                                          CupertinoSwitch(
                                            value: _switchValue,
                                            onChanged: (value) {
                                              setState(() {
                                                // TODO: VTR here
                                                _switchValue = value;
                                                debugPrint(
                                                    "Intiating Virtual Trial Room");
                                                VTR();
                                                // _switchValue = false;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            Divider(
                              color: Colors.black,
                              indent: 16,
                              endIndent: 16,
                              height: 1,
                            ),
// Size selecter

                            Container(
                                // height: math.max(uiHeight / 10, 150),
                                height: 100,
                                // padding: EdgeInsets.all(4),
                                // margin: EdgeInsets.all(4),
                                margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                                color: Colors.white,
                                child: Container(
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        // color: Colors.green[300],
                                        child: Column(
                                          textBaseline:
                                              TextBaseline.ideographic,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.baseline,
                                          children: [
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Container(
                                                // color: Colors.black26,
                                                child: Text(
                                                  "Size",
                                                  // 'levis\'s',
                                                  style: kdetailStyle,
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CustomRadio(),
                                    ],
                                  ),
                                )),

                            Divider(
                              color: Colors.black,
                              indent: 16,
                              endIndent: 16,
                              height: 1,
                            ),
// color selecter
                            Container(
                              // height: math.max(uiHeight / 10, 150),
                              height: 100,
                              padding: EdgeInsets.fromLTRB(8, 9, 9, 0),
                              // margin: EdgeInsets.all(16),
                              color: Colors.white,
                              child: Container(
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      // color: Colors.green[300],
                                      child: Column(
                                        textBaseline: TextBaseline.ideographic,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Container(
                                              // color: Colors.black26,
                                              child: Text(
                                                "Color",
                                                // 'levis\'s',
                                                style: kdetailStyle,
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ),
                                          CustomColorRadio(),
                                          //   child: CustomRadio(),

                                          // )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Divider(
                              color: Colors.black,
                              indent: 16,
                              endIndent: 16,
                              height: 1,
                            ),
// Quantity
                            Container(
                              height: 40,
                              child: Stack(
                                // crossAxisAlignment:
                                //     CrossAxisAlignment.stretch,
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Positioned(
                                    top: 0,
                                    bottom: 0,
                                    left: 0,
                                    child: Container(
                                      // color: Colors.green[300],
                                      child: Center(
                                        child: Text(
                                          "Quantity",
                                          // 'levis\'s',
                                          style: kdetailStyle,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      right: 0,
                                      top: 0,
                                      bottom: 0,
                                      child: MyCounter()),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                              indent: 16,
                              endIndent: 16,
                              height: 1,
                            ),

                            Container(
                              color: Colors.green,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: FlatButton(
                                  onPressed: () {},
                                  child: const Text('ADD TO CART',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  // color: Colors.blue,
                                  color: Colors.green,
                                  textColor: Colors.white,
                                  // elevation: 5,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void VTR() {
    setState(() {
      var res = vtr(context, items['_id']);
      debugPrint("res vtr: $res");

      // images.add(nh.get(res));
      // ++p;
      // for (int i = 0; i < 2; i++) {
      //   debugPrint("$i: ${images[i]}");
      // }
    });
  }
}
