import 'package:flutter/material.dart';

class RowMenu extends StatelessWidget {
  final image;
  final txt;

  const RowMenu({this.image, this.txt});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleAvatar(
          // backgroundColor: Colors.pink,
          // backgroundImage: image,
          child: ClipRRect(
            child: Image.asset(
              image,
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(50.0),
          ),

          radius: 30,
          // maxRadius: 40,
          // minRadius: 30,
        ),
        Text(txt),
      ],
    );
  }
}
