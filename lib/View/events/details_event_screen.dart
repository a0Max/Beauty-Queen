import 'package:beauty_queen/const/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../../const/colors.dart';
import '../../const/styles.dart';
import '../../const/vars.dart';
import '../../controller/events_controller/events_controller.dart';

class DetailsEventsScreen extends StatefulWidget {
  final String eventId;
  const DetailsEventsScreen({super.key, required this.eventId});

  @override
  State<StatefulWidget> createState() {
    return _DetailsEventsScreen();
  }
}

class _DetailsEventsScreen extends State<DetailsEventsScreen> {
  final EventsController controller = Get.put(EventsController());
  @override
  void initState() {
    super.initState();
    controller.currentGetEvents(id: widget.eventId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        //   SizedBox(
        //   height: 50.h,
        // ),
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 30.r,
                color: kBlackColor,
              )),
        ),

        Obx(()=>Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
              children: [
                15.ph,
                Text(controller.event.value.title??'',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,style: TextStyle(
                    fontSize: 16.11.sp,
                    fontWeight: FontWeight.w400,
                    // color: Colors.white,
                    fontFamily: kTheArabicSansLight)),
                15.ph,
                HtmlWidget(controller.event.value.description??''),


              ]),
        ))
      ]),
    );
  }
}
