import 'package:flutter/material.dart';
import 'package:vtr/screen/listGoods.dart';

class MenuWindow extends StatelessWidget {
  final price;
  final discount;
  final brand;
  final imglink;
  final Function onPressed;
  // final image;
  const MenuWindow(
      {this.price, this.brand, this.imglink, this.onPressed, this.discount});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        // () {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => ImageShopingListWidget()),
        //   );
        // },
        child: Container(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
          // color: Colors.red,
          height: 150.0,
          child: Column(
            children: [
              Container(
                height: 145.0,
                child: Image.asset(
                  imglink == null ? "images/discount.jpg" : imglink,
                  fit: BoxFit.fitHeight,
                ),
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
            ],
          ),
        ));
  }
}
