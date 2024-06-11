import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../const/vars.dart';
import '../../models/sales_products_model.dart';
import '../../widgets/product_profile/CustomCardWidget.dart';

class RelatedProductWidget extends StatefulWidget {
  final List data;

  const RelatedProductWidget({super.key, required this.data});
  @override
  State<StatefulWidget> createState() {
    return _RelatedProductWidget();
  }
}

class _RelatedProductWidget extends State<RelatedProductWidget> {
  @override
  void initState() {
    super.initState();
    _startAddingItems();
  }

  Timer? _timer;
  void _startAddingItems() {
    _timer = Timer.periodic(Duration(seconds: 4), (timer) async {
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
        height: 350.h,
        child: ScrollablePositionedList.builder(
          itemCount: (widget.data.length),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, value) => SizedBox(
            width: (MediaQuery.of(context).size.width / 2),
            child: CustomCardWidget(
              // width: (MediaQuery.of(context).size.width / 2) - 40,
              imageUrl: Connection.urlOfProducts(
                  image: widget.data[value].mainImage ?? ''),

              isDiscount: widget.data[value].isOffer,
              newArrival: widget.data[value] ?? SalesProductsModel(),
              favorite: widget.data[value].wishlist?.isNotEmpty ?? false,
            ),
          ),
          itemScrollController: itemScrollController,
          scrollOffsetController: scrollOffsetController,
          itemPositionsListener: itemPositionsListener,
          scrollOffsetListener: scrollOffsetListener,
        )
        // ListView.builder(
        //     physics: PageScrollPhysics(), // this is what you are looking for
        //     // physics: SnappingScrollPhysics(),
        //     itemCount: (widget.data.length),
        //     controller: _pageController,
        //     scrollDirection: Axis.horizontal,
        //     // shrinkWrap: true,
        //     itemBuilder: (context, value) {
        //       return Container(
        //         width: (MediaQuery.of(context).size.width / 2),
        //         child: CustomCardWidget(
        //           // width: (MediaQuery.of(context).size.width / 2) - 40,
        //           imageUrl: Connection.urlOfProducts(
        //               image: widget.data[value].mainImage ?? ''),
        //
        //           isDiscount: widget.data[value].isOffer,
        //           newArrival: widget.data[value] ?? SalesProductsModel(),
        //           favorite: widget.data[value].wishlist?.isNotEmpty ?? false,
        //         ),
        //       );
        //     }),
        );
  }
}
