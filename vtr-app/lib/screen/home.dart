import 'package:flutter/material.dart';
import 'package:vtr/screen/RowMenu.dart';
import 'package:vtr/screen/SilverHeader.dart';
import 'package:vtr/screen/listGoods.dart';

import '../constrant.dart';
import 'MainWindow.dart';

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('VTR'),
        // ),
        body: HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  // var random = new Random();
  final controller = PageController(viewportFraction: 0.8);

  SliverPersistentHeader makeHeader(Widget headerText, Widget appbar) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 80.0,
        maxHeight: 250.0,
        appbar: appbar,
        child: Container(
            color: Colors.blue[600], child: Center(child: headerText)),
      ),
    );
  }

  SliverAppBar makeHeader1(Widget headerText) {
    return SliverAppBar(
        // pinned: true,
        floating: false,
        backgroundColor: Colors.blue[600],
        actions: [
          Icon(Icons.menu),
        ],
        expandedHeight: 200,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Container(
              color: Colors.blue[600], child: Center(child: headerText)),
        ));
  }

  @override
  Widget build(BuildContext context) {
    double uiHeight = MediaQuery.of(context).size.height;
    double size = MediaQuery.of(context).size.height;
    double graphHeight = size * 0.21;

    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            // Hero(tag: "Todotag", child: makeHeader('Todo')),
            //  TODO: add hero animation
            // makeHeader('Todo'),

            SliverAppBar(
                title: Text('HOME'),
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
                // <-- app bar for logo
                leading: IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  tooltip: 'Show Snackbar',
                  onPressed: () {
                    Navigator.pop(context);

                    // ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(content: Text('This is a snackbar')));
                  },
                ),
                expandedHeight: ((uiHeight / 3)),
                floating: false,
                pinned: false,
                elevation: 0.0,
                backgroundColor: Colors.blue[600],
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
                        child: Container(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  // crossAxisAlignment: CrossAxisAlignment.baseline,
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        'NEW \nARRIVALS',
                                        style: kTodoStyle,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        '2000+ New items',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white70,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   height: size * 0.25 * 0.25 * 0.25,
                              // ),
                              Container(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        'Shop now ->',
                                        style: kSubTextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(height: 16),

                        // Image.asset(
                        //   'images/men.jpg',
                        //   fit: BoxFit.fitHeight,
                        //   // width: 120,
                        //   height: uiHeight / 2,
                        // ),
                      ),
                    ],
                  ),
                ))),

            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Stack(children: [
                    Container(
                      height: 100,
                      child: Column(
                        children: [
                          Expanded(
                            // flex: 4,
                            child: Container(
                              // height: size * 0.3,
                              // color: Color(0xFFFFA012),
                              color: Colors.blue[600],
                            ),
                          ),
                          Expanded(
                            // flex: 6,
                            child: Container(
                                // height: size * 0.6,
                                // color: Color(0xFF141438),
                                ),
                          ),
                        ],
                      ),
                      // color: Colors.pink,
                    ),
                    Center(
                      child: Container(
                        color: Colors.white,
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(8),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RowMenu(
                              txt: 'MEN',
                              image: "images/men.jpg",
                            ),
                            RowMenu(
                              txt: 'WOMEN',
                              image: "images/female.jpg",
                            ),
                            RowMenu(
                              txt: 'KIDS',
                              image: "images/kids.jpg",
                            ),
                            RowMenu(
                              txt: 'OFFERS',
                              image: "images/offer.jpg",
                            ),
                          ],
                        ),
                      ),
                    )
                  ]),

                  Container(
                    color: Colors.white,
                    height: size / 5,
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8),
                    child: Image.asset(
                      "images/discount.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),

                  // SizedBox(
                  //   height: size * 2.5,
                  // ),
                ],
              ),
            ),

            SliverGrid.count(
              crossAxisCount: 2,
              children: [
                MenuWindow(
                  price: 1000,
                  discount: 32,
                  brand: "levi's",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageShopingListWidget()),
                    );
                  },
                  imglink: "images/tshirt.jpg",
                ),
                MenuWindow(
                  price: 1000,
                  discount: 32,
                  brand: "levi's",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageShopingListWidget()),
                    );
                  },
                  imglink: "images/shirt.jpg",
                ),
                MenuWindow(
                  price: 1000,
                  discount: 32,
                  brand: "levi's",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageShopingListWidget()),
                    );
                  },
                  imglink: "images/jeans.jpg",
                ),
                MenuWindow(
                  price: 1000,
                  discount: 32,
                  brand: "levi's",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageShopingListWidget()),
                    );
                  },
                  imglink: "images/pant.jpg",
                ),
                MenuWindow(
                  price: 1000,
                  discount: 32,
                  brand: "levi's",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageShopingListWidget()),
                    );
                  },
                  imglink: "images/pant.jpg",
                ),
                MenuWindow(
                  price: 1000,
                  discount: 32,
                  brand: "levi's",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageShopingListWidget()),
                    );
                  },
                  imglink: "images/saree.jpg",
                ),
                MenuWindow(
                  price: 1000,
                  discount: 32,
                  brand: "levi's",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageShopingListWidget()),
                    );
                  },
                  imglink: "images/kurta.jpg",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
