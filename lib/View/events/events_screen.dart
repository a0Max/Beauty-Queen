import 'package:beauty_queen/const/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../../const/styles.dart';
import '../../const/vars.dart';
import '../../controller/events_controller/events_controller.dart';
import '../../widgets/shimmer/shimmer_item.dart';
import 'details_event_screen.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EventsScreen();
  }
}

class _EventsScreen extends State<EventsScreen> {
  final EventsController controller = Get.put(EventsController());
  @override
  void initState() {
    super.initState();
    controller.getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => ListView(children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 30.r,
                    color: AppColors.kBlackColor,
                  )),
            ),
            Text(
              'المعرض',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.mainColor,
                fontSize: 27.sp,
                fontFamily: kTheArabicSansLight,
                fontWeight: FontWeight.w600,
              ),
            ),
            20.ph,
            controller.isLoading.value == true
                ? const Center(child: ShimmerItem())
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                        children: List.generate(
                            controller.eventsList.length ?? 0,
                            (index) => InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailsEventsScreen(
                                                  eventId:
                                                      "${controller.eventsList[index].id}",
                                                )));
                                  },
                                  child: Container(
                                    // height: 100,
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: Column(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: Connection.urlOfEvent(
                                              image: controller
                                                  .eventsList[index]
                                                  .coverImage
                                                  .file),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 450.h,
                                          fit: BoxFit.fill,
                                        ),
                                        Container(
                                          height: 100.h,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.w, vertical: 10.h),
                                          decoration: const BoxDecoration(
                                              color: AppColors.mainColor),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.7,
                                                child: Text(
                                                  controller.eventsList[index]
                                                          .title ??
                                                      '',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 18.11.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white,
                                                      fontFamily:
                                                          kTheArabicSansLight),
                                                  maxLines: 3,
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 15.h),
                                                child: GestureDetector(
                                                  onTap: () {},
                                                  child: Container(
                                                    // height: 49.70.h,
                                                    decoration: ShapeDecoration(
                                                      color:
                                                          AppColors.klPinkColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.84),
                                                      ),
                                                    ),
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Text('اطلعي الآن',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  15.11.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: AppColors
                                                                  .mainColor,
                                                              fontFamily:
                                                                  kTheArabicSansLight)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ))),
                  )
          ])),
    );
  }
}
