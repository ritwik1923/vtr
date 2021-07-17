import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vtr/networkHandler/NetworkHandler.dart';
import 'package:vtr/screen/indi_clothView1.dart';
import 'package:intl/intl.dart';

class ImageShopingListWidget extends StatefulWidget {
  @override
  @override
  _ImageShopingListWidgettState createState() =>
      _ImageShopingListWidgettState();
}

class _ImageShopingListWidgettState extends State<ImageShopingListWidget> {
  NetworkHandler nh = NetworkHandler();
  List items;
  var img = null;
  final oCcy = new NumberFormat("#,##0.00", "en_US");

  _ImageShopingListWidgettState();

  @override
  void initState() {
    super.initState();
    this.getAlldata();
  }

  Future getAlldata() async {
    final res = await nh.allData("/getallcloths");
    debugPrint("res :: $res");
    // img = await nh.getcloths("/getcloths", 'men-2689543267705558');

    this.setState(() {
      items = res;
      debugPrint("responded  ${res.length} \n\n$img\n\n");

      // debugPrint("responded  $items");
    });
    // print(items[0].data);
  }

  @override
  Widget build(BuildContext context) {
    double uiHeight = MediaQuery.of(context).size.height;
    double uiWidth = MediaQuery.of(context).size.width;
    double cardHeight = 174;
    double cardWidth = uiWidth;
    String stock = "";
    return Scaffold(
        // appBar: new AppBar(
        //     title: new Text("Topwear"), backgroundColor: Colors.blue),

        appBar: AppBar(
          titleSpacing: 10,
          backgroundColor: Colors.blue[600],
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new)),
          title: Text('Topwear'),
          actions: [
            // https://stackoverflow.com/questions/61108513/how-can-i-make-bell-notification-icon-animated-in-flutter
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Icon(Icons.alarm)),

            Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Icon(Icons.shopping_bag)),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Icon(Icons.more_vert_outlined)),
          ],
        ),
        body: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          // Generate 100 widgets that display their index in the List.
          children:
              List.generate(items == null ? 0 : items.length * 1000, (index) {
            var brand = 'levi\'s';
            var price = (index + 1000) % 1999;
            var discount = index * 50 % 29;
            var item = {
              "_id": items[index % 4]['_id'],
              "price": price,
              "discount": discount,
              "brand": brand,
            };
            return GestureDetector(
                onTap: () {
                  debugPrint("$index : ${items[index]["_id"]} ");
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Index_Cloth(item: item)));
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  height: 150,
                  child: Column(children: [
                    Container(
                      // color: Colors.pink,
                      child: Image.network(
                        "http://127.0.0.1:5000/getcloths?id=${items[index % 4]['_id']}",
                        fit: BoxFit.fill,
                        height: 145,
                      ),

                      // ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              brand,
                              // 'levis\'s',
                              style: TextStyle(
                                fontSize: 20,
                                // fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.ideographic,
                            // mainAxisAlignment: MainAxisAlignment.b,
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  '₹$price',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    // color: Colors.white70,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  '₹${price * (100 + discount) / 100}',
                                  style: TextStyle(
                                    textBaseline: TextBaseline.ideographic,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  '($discount% off)',
                                  style: TextStyle(
                                    textBaseline: TextBaseline.ideographic,
                                    fontSize: 12,
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ]),
                ));
          }),
        ));
  }
}
