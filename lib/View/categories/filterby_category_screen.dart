import 'package:beauty_queen/const/colors.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/AlKasam_controller/alkasam_controller.dart';
import '../../controller/discounts_controller/sales_controller.dart';

class FilterByCategoryContainer extends StatefulWidget {
  const FilterByCategoryContainer({super.key});

  @override
  State<FilterByCategoryContainer> createState() => _FilterByCategoryContainer();
}

class _FilterByCategoryContainer extends State<FilterByCategoryContainer> {
  @override
  Widget build(BuildContext context) {
    final AlkasamController controller = Get.put(AlkasamController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(
            height: 64.h,
            width: MediaQuery.of(context).size.width,
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
          Expanded(
            child: SingleChildScrollView(
              child: Obx(() => Column(
                    children: [
                      if ((controller.generalSearchData.value.brands?.length ??
                              0) >
                          0) ...{
                        ExpansionTile(
                          title: Text(tr('brands'),
                              style: TextStyle(
                                  fontFamily: kTheArabicSansLight,
                                  color: kBlackColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17.sp)),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          collapsedShape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          children: List.generate(
                              controller
                                      .generalSearchData.value.prices?.length ??
                                  0,
                              (index) => Column(
                                    children: [
                                      FilterOption(
                                          text: controller.generalSearchData
                                                  .value.brands?[index].title ??
                                              '',
                                          isChecked: controller
                                              .selectedBrands.value
                                              .contains(controller
                                                  .generalSearchData
                                                  .value
                                                  .brands?[index]
                                                  .id.toString()),
                                          onChanged: (val) {
                                            controller.updateSelectedBrands(
                                                newSelected: controller
                                                        .generalSearchData
                                                        .value
                                                        .brands?[index]
                                                        .id ??
                                                    0);
                                          }),
                                      Divider(
                                        color: kPrimaryColor,
                                        thickness: 1.w,
                                      ),
                                    ],
                                  )),
                        ),
                      },
                      if ((controller.generalSearchData.value.labels?.length ??
                              0) >
                          0) ...{
                        ...List.generate(
                            controller.generalSearchData.value.labels?.length ??
                                0,
                            (index) => Column(
                                  children: [
                                    FilterOption(
                                        text: controller.generalSearchData.value
                                                .labels?[index].text ??
                                            '',
                                        isChecked: controller
                                            .selectedLabels.value
                                            .contains(controller
                                                .generalSearchData
                                                .value
                                                .labels?[index]
                                                .id.toString()),
                                        onChanged: (val) {
                                          controller.updateSelectedLabel(
                                              newSelected: int.parse(controller
                                                      .generalSearchData
                                                      .value
                                                      .labels?[index]
                                                      .id
                                                      .toString() ??
                                                  "0"));
                                        }),
                                    Divider(
                                      color: kPrimaryColor,
                                      thickness: 1.w,
                                    ),
                                  ],
                                )),
                      },
                      if ((controller.generalSearchData.value.labels?.length ??
                              0) >
                          0) ...{
                        ExpansionTile(
                          title: Text(tr('price'),
                              style: TextStyle(
                                  fontFamily: kTheArabicSansLight,
                                  color: kBlackColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17.sp)),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          collapsedShape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          children: List.generate(
                              controller
                                      .generalSearchData.value.prices?.length ??
                                  0,
                              (index) => Column(
                                    children: [
                                      FilterOption(
                                          text: controller.generalSearchData
                                                  .value.prices?[index] ??
                                              '',
                                          isChecked: controller
                                              .selectedPrices.value
                                              .contains(index.toString()),
                                          onChanged: (val) {
                                            controller.updateSelectedPrices(
                                                newSelected: index);
                                          }),
                                      Divider(
                                        color: kPrimaryColor,
                                        thickness: 1.w,
                                      ),
                                    ],
                                  )),
                        ),
                      },
                    ],
                  )),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 40.h, top: 20.h),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: kWhiteColor, boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(32, 0, 0, 0),
                blurRadius: 28.r,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ]),
            child: Column(
              children: [
                Text(
                    '${tr('project')}: ${controller.generalSearchData.value.salesCount ?? ''}',
                    style: TextStyle(
                      fontFamily: kTheArabicSansLight,
                      color: kGrayColor,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                    )),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        controller.clearSelected();
                        Navigator.of(context).pop();
                      },
                      child: Container(
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
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    GestureDetector(
                      onTap: (){
                        controller.applySelected();
                        Navigator.of(context).pop();
                      },
                      child: Container(
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
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FilterOption extends StatelessWidget {
  final String text;
  final ValueChanged<bool?>? onChanged;

  const FilterOption(
      {super.key, required this.text, required this.isChecked, this.onChanged});
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          checkColor: kWhiteColor,
          activeColor: kPrimaryColor,
          value: isChecked,
          onChanged: onChanged,
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          text,
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
