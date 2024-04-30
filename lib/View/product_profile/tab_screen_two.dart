import 'dart:developer';
import 'dart:io';

import 'package:beauty_queen/const/app_images.dart';
import 'package:beauty_queen/const/extensions.dart';
import 'package:beauty_queen/widgets/based/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
// import '../../const/images.dart';
import '../../const/styles.dart';
import '../../const/validator.dart';
import '../../controller/product_controller/product_profile_controller.dart';
import '../../widgets/based/error_pop_up.dart';
import '../../widgets/product_profile/rating_widget.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class TabScreenTwo extends StatelessWidget {
  TabScreenTwo({super.key});
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final ProductProfileController controller =
    //     Get.put(ProductProfileController());
    return GetBuilder<ProductProfileController>(builder: (controller) {
      return Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.h,
              ),
              TextFormField(
                maxLines: 5,
                controller: commentController,
                decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.kPrimaryColor, width: 2.w)),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.kPrimaryColor, width: 2.w)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.kPrimaryColor, width: 2.w)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.kPrimaryColor, width: 2.w)),
                  hintText: tr('writeReview'),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.kPrimaryColor, width: 2.w)),
                ),
                validator: (val) {
                  return Validator().validatorRequired(val);
                },
                // onChanged: (val) {
                //   // controller.updateComment(newComment: val);
                // },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.getImage();
                    },
                    child: Text(
                      tr('addPic'),
                      style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          decorationColor: AppColors.kPrimaryColor,
                          decoration: TextDecoration.underline,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.kPrimaryColor),
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  RatingWidget(
                    maxRating: 5,
                    allowToEdit: true,
                  ),
                ],
              ),
              SizedBox(
                height: 22.w,
              ),
              if (controller.imagePath.value != null &&
                  controller.imagePath.value != '')
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File(controller.imagePath
                            .value), // Replace with the actual path to your image
                        width: 200,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      child: CircleAvatar(
                        radius:
                            15, // Adjust the radius based on your preference
                        backgroundColor: Colors.grey.withOpacity(.8),
                        // child:
                        child: IconButton(
                            onPressed: () {
                              controller.clearImage();
                            },
                            icon: const Icon(
                              Icons.close_sharp,
                              color: Colors.black,
                              size: 15,
                            )),
                      ),
                    )
                  ],
                ),
              20.ph,
              GestureDetector(
                onTap: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  _formKey.currentState!.save();
                  try {
                    LoadingScreen.show(context);
                    await controller.verifyToAddReview(
                        comment: commentController.text);
                    Navigator.of(context).pop();
                    controller.showCompleteComment();
                    controller.clearData();
                    commentController.clear();
                  } on DioException catch (e) {
                    Navigator.of(context).pop();
                    try {
                      ErrorPopUp(
                          message: (e.response?.data as Map).values.first,
                          title: 'خطا');
                    } catch (e) {
                      ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
                    }
                  } catch (e) {
                    Navigator.of(context).pop();

                    log('verifyToAddReview:error:$e');
                    if (e == 'Check Network connection') {
                      ErrorPopUp(
                          message: tr('network_connection'), title: 'خطا');
                    } else {
                      ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
                    }
                  }
                },
                child: Container(
                  height: 37.83.h,
                  width: 131.w,
                  color: AppColors.kPrimaryColor,
                  child: Center(
                    child: Text(
                      tr('send2'),
                      style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.kWhiteColor),
                    ),
                  ),
                ),
              ),
              if (controller.isLoading.value != true)
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.productData.last.reviews.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.productData.last?.reviews?[index]
                                          ?.user?.name ??
                                      '',
                                  style: const TextStyle(
                                      fontFamily: kTheArabicSansLight,
                                      fontWeight: FontWeight.bold),
                                ),
                                RatingWidget(
                                    allowToEdit: false,
                                    maxRating: 5,
                                    currentRating: int.parse(
                                        "${controller.productData.last?.reviews?[index].rating ?? 0}")),
                              ],
                            ),
                            5.ph,
                            Text(controller.productData.last?.reviews?[index]
                                    ?.comment ??
                                ''),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${controller.productData.last?.reviews?[index]?.createdAt.split('T').first} ${controller.productData.last?.reviews?[index]?.createdAt.split('T').last.substring(0, 5)}',
                                  style: const TextStyle(
                                      // fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.kBlackColor),
                                  textAlign: TextAlign.center,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        try {
                                          LoadingScreen.show(context);
                                          await controller.addLikeReaction(
                                              productId:
                                                  "${controller.productData.last?.reviews?[index]?.id ?? 0}");
                                          Navigator.of(context).pop();
                                        } on DioException catch (e) {
                                          Navigator.of(context).pop();

                                          ErrorPopUp(
                                              message: (e.response?.data as Map)
                                                  .values
                                                  .first,
                                              title: 'خطا');
                                        } catch (e) {
                                          Navigator.of(context).pop();

                                          log('verifyToAddReview:error:$e');
                                          if (e == 'Check Network connection') {
                                            ErrorPopUp(
                                                message:
                                                    tr('network_connection'),
                                                title: 'خطا');
                                          } else {
                                            ErrorPopUp(
                                                message: tr('something_wrong'),
                                                title: 'خطا');
                                          }
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            '(${controller.productData.last?.reviews?[index]?.likes ?? 0})',
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                          SvgPicture.asset(
                                            AppImages.likeImage,
                                            height: 10,
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                    10.pw,
                                    InkWell(
                                      onTap: () {
                                        try {
                                          LoadingScreen.show(context);
                                          controller.addDisLikeReaction(
                                              productId:
                                                  "${controller.productData.last?.reviews?[index]?.id ?? 0}");
                                          Navigator.of(context).pop();
                                        } on DioException catch (e) {
                                          Navigator.of(context).pop();

                                          ErrorPopUp(
                                              message: (e.response?.data as Map)
                                                  .values
                                                  .first,
                                              title: 'خطا');
                                        } catch (e) {
                                          Navigator.of(context).pop();

                                          log('verifyToAddReview:error:$e');
                                          if (e == 'Check Network connection') {
                                            ErrorPopUp(
                                                message:
                                                    tr('network_connection'),
                                                title: 'خطا');
                                          } else {
                                            ErrorPopUp(
                                                message: tr('something_wrong'),
                                                title: 'خطا');
                                          }
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            '(${controller.productData.last?.reviews?[index]?.dislikes ?? 0})',
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                          SvgPicture.asset(
                                            AppImages.disLikeImage,
                                            height: 10,
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            25.ph
                          ],
                        ),
                      );
                    })
            ],
          ));
    });
  }
}
