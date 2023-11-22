// ignore_for_file: library_private_types_in_public_api

import 'package:beauty_queen/const/colors.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FilterByContainer extends StatefulWidget {
  const FilterByContainer({super.key});

  @override
  State<FilterByContainer> createState() => _FilterByContainerState();
}

class _FilterByContainerState extends State<FilterByContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 64.h,
              width: 403.w,
              color: kBlackColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100.w,
                  ),
                  Center(
                    child: Text(
                      "فلترة النتائج",
                      style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          fontSize: 21.sp,
                          fontWeight: FontWeight.w500,
                          color: kWhiteColor),
                    ),
                  ),
                  SizedBox(
                    width: 130.w,
                  ),
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.close,
                        color: kWhiteColor,
                        size: 30.r,
                      )),
                ],
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ExpansionTile(
                  title: Text('الماركة',
                      style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          color: kBlackColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 17.sp)),
                  children: [
                    const FilterOption(text: 'One Brand'),
                    Divider(
                      color: kPrimaryColor,
                      thickness: 1.w,
                    ),
                    const FilterOption(text: 'One Brand'),
                    Divider(
                      color: kPrimaryColor,
                      thickness: 1.w,
                    ),
                    const FilterOption(text: 'One Brand'),
                    Divider(
                      color: kPrimaryColor,
                      thickness: 1.w,
                    ),
                    const FilterOption(text: 'One Brand'),
                    Divider(
                      color: kPrimaryColor,
                      thickness: 1.w,
                    ),
                    const FilterOption(text: 'One Brand'),
                    Divider(
                      color: kPrimaryColor,
                      thickness: 1.w,
                    ),
                    const FilterOption(text: 'One Brand'),
                    Divider(
                      color: kPrimaryColor,
                      thickness: 1.w,
                    ),
                    const FilterOption(text: 'One Brand'),
                  ],
                ),
              ],
            ),
            Divider(
              color: kPrimaryColor,
              thickness: 1.w,
            ),
            const FilterOption(text: 'تخفيض'),
            Divider(
              color: kPrimaryColor,
              thickness: 1.w,
            ),
            const FilterOption(text: 'اونلاين فقط'),
            Divider(
              color: kPrimaryColor,
              thickness: 1.w,
            ),
            const FilterOption(text: 'وصل حديثاً'),
            Divider(
              color: kPrimaryColor,
              thickness: 1.w,
            ),
            const FilterOption(text: 'جديد'),
            Divider(
              color: kPrimaryColor,
              thickness: 1.w,
            ),
            const FilterOption(text: 'حصرياً في بيوتي كوين'),
            Divider(
              color: kPrimaryColor,
              thickness: 1.w,
            ),
            const FilterOption(text: 'اشتري 2+1 مجاناً'),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ExpansionTile(
                  title: Text('السعر',
                      style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          color: kBlackColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 17.sp)),
                  children: [
                    const FilterOption(text: 'أقل من 5 دل'),
                    Divider(
                      color: kPrimaryColor,
                      thickness: 1.w,
                    ),
                    const FilterOption(text: ' من 5 دل الي 10 دل'),
                    Divider(
                      color: kPrimaryColor,
                      thickness: 1.w,
                    ),
                    const FilterOption(text: ' من 5 دل الي 10 دل'),
                    Divider(
                      color: kPrimaryColor,
                      thickness: 1.w,
                    ),
                    const FilterOption(text: ' من 5 دل الي 10 دل'),
                    Divider(
                      color: kPrimaryColor,
                      thickness: 1.w,
                    ),
                    const FilterOption(text: ' من 5 دل الي 10 دل'),
                    Divider(
                      color: kPrimaryColor,
                      thickness: 1.w,
                    ),
                    const FilterOption(text: ' من 5 دل الي 10 دل'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 150.h)
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 25.h),
        child: FloatingActionButton.extended(
          onPressed: () {},
          label: Container(
            height: 149.97.h,
            width: 429.w,
            decoration: BoxDecoration(color: kWhiteColor, boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(32, 0, 0, 0),
                blurRadius: 28.r,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 39.55.h,
                  width: 95.w,
                  decoration: BoxDecoration(
                      border: Border.all(color: kPrimaryColor, width: 1.w),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Center(
                    child: Text(
                      "مسح الكل",
                      style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w700,
                          color: kPrimaryColor),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Container(
                  height: 39.55.h,
                  width: 95.w,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      border: Border.all(color: kPrimaryColor, width: 1.w),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Center(
                    child: Text(
                      'حفظ الخيارات',
                      style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: kWhiteColor),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FilterOption extends StatefulWidget {
  final String text;

  const FilterOption({super.key, required this.text});

  @override
  _FilterOptionState createState() => _FilterOptionState();
}

class _FilterOptionState extends State<FilterOption> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          checkColor: kWhiteColor,
          activeColor: kPrimaryColor,
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          widget.text,
          style: TextStyle(
              fontFamily: kTheArabicSansLight,
              color: kBlackColor,
              fontWeight: FontWeight.w700,
              fontSize: 17.sp),
        ),
      ],
    );
  }
}
