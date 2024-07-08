import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../const/vars.dart';
import '../../models/sales_products_model.dart';
import '../../widgets/product_profile/CustomCardWidget.dart';

class AutoScrollOfNewArrive extends StatefulWidget {
  final List data;

  const AutoScrollOfNewArrive({super.key, required this.data});
  @override
  State<StatefulWidget> createState() {
    return _AutoScrollOfNewArrive();
  }
}

class _AutoScrollOfNewArrive extends State<AutoScrollOfNewArrive> {
  @override
  void initState() {
    super.initState();
    _startAddingItems();
  }

  Timer? _timer;
  void _startAddingItems() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      scrollOffsetController.animateScroll(
          offset: MediaQuery.of(context).size.width / 2,
          duration: Duration(milliseconds: 500));
      if (itemPositionsListener.itemPositions.value.last.index ==
          widget.data.length - 2) {
        await Future.delayed(Duration(seconds: 4));
        itemScrollController.jumpTo(index: 0);
      }
    });
  }

  final ItemScrollController itemScrollController = ItemScrollController();
  ScrollOffsetController scrollOffsetController = ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 349.h,
        child: ScrollablePositionedList.builder(
          itemCount: (widget.data.length),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => FittedBox(
            child: SizedBox(
                width: (MediaQuery.of(context).size.width / 2),
                child: CustomCardWidget(
                  hideTage: true,
                  imageUrl: Connection.urlOfProducts(
                      image: widget.data[index].mainImage ?? ''),
                  // isDiscount: _controller.homeData.value
                  //     .newArrivals?[index].isOffer,
                  newArrival: widget.data[index] ?? SalesProductsModel(),
                  favorite: widget.data[index].wishlist?.isNotEmpty ?? false,
                )),
          ),
          itemScrollController: itemScrollController,
          scrollOffsetController: scrollOffsetController,
          itemPositionsListener: itemPositionsListener,
          scrollOffsetListener: scrollOffsetListener,
        ));
  }
}
