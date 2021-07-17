import 'package:flutter/material.dart';
import 'dart:math' as math;

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  double hh = 10;

  SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
    @required this.appbar,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  final Widget appbar;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var currheight = MediaQuery.of(context).size.height;
    print("currheight: $shrinkOffset");
    if (shrinkOffset >= 50 && shrinkOffset <= maxHeight && appbar != null) {
      return appbar;
      // SliverAppBar(
      //   // pinned: true,
      //   floating: false,
      //   backgroundColor: Colors.blue[600],
      //   actions: [
      //     Icon(Icons.menu),
      //   ],
      //   // expandedHeight: 200,
      //   // bottom: PreferredSize(
      //   //   preferredSize: Size.fromHeight(0),
      //   //   child: Container(
      //   //       color: Colors.blue[600], child: Center(child: headerText)),
      //   // )
      // );
    } else {
      if (appbar != null) {
        return Column(
          children: [
            appbar,
            // new SizedBox.expand(
            //   child:
            // )
            Expanded(child: child),
          ],
        );
      } else {
        return Column(
          children: [
            // new SizedBox.expand(
            //   child:
            // )
            Expanded(child: child),
          ],
        );
      }
    }
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
