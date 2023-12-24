import 'package:beauty_queen/const/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../../const/styles.dart';
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

  final PageController _pageController1 = PageController();
  final PageController _pageController2 = PageController();
  final PageController _pageController3 = PageController();
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
                color: AppColors.kBlackColor,
              )),
        ),

        Obx(() => controller.isLoading2.value == true
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 410.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                controller.currentImage.value),
                            fit: BoxFit.fill)),
                  ),
                  15.ph,
                  SizedBox(
                      height: 120.h,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 120.h,
                                width: MediaQuery.of(context).size.width / 4,
                                child: PageView.builder(
                                    controller: _pageController3,
                                    itemCount: controller.listOfImage.length,
                                    itemBuilder: (context, index) {
                                      if (index > 0) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          controller.listOfImage
                                                                  .value[
                                                              index - 1]),
                                                  fit: BoxFit.fill)),
                                        );
                                      } else {
                                        return SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          height: 120.h,
                                        );
                                      }
                                    }),
                              ),
                              SizedBox(
                                height: 120.h,
                                width: MediaQuery.of(context).size.width / 4,
                                child: PageView.builder(
                                    controller: _pageController2,
                                    itemCount: controller.listOfImage.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                                image:
                                                    CachedNetworkImageProvider(
                                                        controller.listOfImage
                                                            .value[index]),
                                                fit: BoxFit.fill)),
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: 120.h,
                                width: MediaQuery.of(context).size.width / 4,
                                child: PageView.builder(
                                    controller: _pageController1,
                                    itemCount: controller.listOfImage.length,
                                    itemBuilder: (context, index) {
                                      if ((index + 1) <
                                              controller
                                                  .listOfImage.value.length &&
                                          controller.listOfImage
                                                  .value[index + 1] !=
                                              null) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          controller.listOfImage
                                                                  .value[
                                                              index + 1]),
                                                  fit: BoxFit.fill)),
                                        );
                                      } else {
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          height: 120.h,
                                        );
                                      }
                                      return null;
                                    }),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  _pageController1.previousPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );
                                  _pageController2.previousPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );
                                  _pageController3.previousPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(7),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white60),
                                    child: const Icon(
                                        Icons.arrow_back_ios_new_outlined)),
                              ),
                              InkWell(
                                onTap: () {
                                  _pageController1.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );

                                  _pageController2.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );

                                  _pageController3.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(7),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white60),
                                    child: const Icon(
                                        Icons.arrow_forward_ios_rounded)),
                              ),
                            ],
                          ),
                        ],
                      )),
                  15.ph,
                  Text(controller.event.value.title ?? '',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                          fontSize: 16.11.sp,
                          fontWeight: FontWeight.w400,
                          // color: Colors.white,
                          fontFamily: kTheArabicSansLight)),
                  15.ph,
                  HtmlWidget(controller.event.value.description ?? ''),
                ]),
              ))
      ]),
    );
  }
}
