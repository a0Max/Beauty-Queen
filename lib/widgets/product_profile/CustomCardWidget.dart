// ignore_for_file: file_names

import 'package:beauty_queen/const/extensions.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:beauty_queen/widgets/product_profile/CustomAlertBox.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../View/brands/branddetail_screen.dart';
import '../../View/product_profile/products_screen.dart';
import '../../const/app_colors.dart';
import '../../controller/auth_controller/auth_controler.dart';
import '../../controller/home_controller/home_controller.dart';
import '../../controller/nav_bar_controller/NavBarController.dart';
import '../../controller/product_controller/product_profile_controller_provider.dart';
import '../../models/label_model.dart';
import '../../models/options_model.dart';
import '../../models/product_options_model.dart';
import '../../models/sales_products_model.dart';
import '../../models/user_model.dart';
import '../currentPriceWithBlack.dart';
import '../currentPriceWithPink.dart';
import '../oldPriceWithBlack.dart';

class CustomCardWidget extends StatefulWidget {
  final String imageUrl;
  final LabelModel? newTag;
  final SalesProductsModel newArrival;
  final double? width;
  final String? isDiscount;
  final bool favorite;
  final bool? hideLike;
  final bool? hideTage;
  // final bool? sale;

  const CustomCardWidget({
    super.key,
    required this.imageUrl,
    required this.newArrival,
    this.width,
    this.isDiscount,
    this.newTag,
    required this.favorite,
    this.hideLike = false,
    this.hideTage = false,
    // this.sale = false,
  });

  @override
  State<CustomCardWidget> createState() => _CustomCardWidgetState();
}

class _CustomCardWidgetState extends State<CustomCardWidget> {
  bool isFavorite = false;
  bool showProductOptions = false;
  OptionsModel? selectedOption;
  ProductOptionsModel? selectedParentOption;
  final HomeController _controller = Get.put(HomeController());
  @override
  void initState() {
    super.initState();
    isFavorite = widget.favorite;
  }

  final NavController controller = Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    final productOptionsIsEmpty =
        widget.newArrival.productOptions?.isEmpty ?? false;
    final productIsFlashDiscount = widget.newArrival.isFlashDiscount;
    final productIsOffer = widget.newArrival.isOffer;
    final productMainPrice = widget.newArrival.price;
    final productFlashDiscountPrice = widget.newArrival.flashDiscountPrice;
    final productOfferPrice = widget.newArrival.offerPrice;
    final selectedOptionsPrice = widget.newArrival.price;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4), // Customize the shadow color
            spreadRadius: 0.5, // Customize how far the shadow spreads
            blurRadius: 9, // Customize the blur radius
            offset: const Offset(0, 5), // Customize the offset
          ),
        ],
        color: Colors.white,
      ),
      width: widget.width ?? (MediaQuery.of(context).size.width / 2) - 20,
      // height: 152.27.h,
      child: InkWell(
        onTap: () {
          final AuthController _controllerLogin = Get.put(AuthController());
          UserModel user = _controllerLogin.userData.value;
          print('%%%%%%%%%:${user.id}');
          if (user.id == null) {
            _controllerLogin.alertOfLogin();
            return;
          }
          // Get.lazyPut(()=>ProductProfileController());
          // Get.to(ItemProfilePage(itemId:widget.newArrival.id??0));
          print('%%%%%%%%%');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                      create: (context) => ProductProfileControllerProvider(),
                      child:
                          ItemProfilePage(itemId: widget.newArrival.id ?? 0))));
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showProductOptions == true &&
                (widget.newArrival.productOptions != null &&
                    widget.newArrival.productOptions?.isNotEmpty == true)) ...{
              Stack(
                children: [
                  Positioned(
                      child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        showProductOptions = false;
                      });
                    },
                  )),
                  Column(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200.h,
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Column(
                            children: List.generate(
                                widget.newArrival.productOptions?.length ?? 0,
                                (index) => Column(
                                      children: [
                                        Text(
                                          widget
                                                  .newArrival
                                                  .productOptions?[index]
                                                  .title ??
                                              '',
                                          style: const TextStyle(
                                              fontFamily: kTheArabicSansLight,
                                              color: AppColors.kGreyBlueColor,
                                              fontSize: 18),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton2(
                                              isExpanded: true,
                                              items: widget
                                                  .newArrival
                                                  .productOptions?[index]
                                                  .options
                                                  ?.toList()
                                                  .map((item) {
                                                return DropdownMenuItem<
                                                    OptionsModel>(
                                                  value: item,
                                                  child: Text(
                                                    item.title ?? '',
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontFamily:
                                                            kTheArabicSansLight,
                                                        color: Colors.white),
                                                    // maxLines: 1,
                                                    // overflow: TextOverflow.ellipsis,
                                                  ),
                                                );
                                              }).toList(),
                                              value: selectedOption,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedOption = value;
                                                  selectedParentOption = widget
                                                              .newArrival
                                                              .productOptions?[
                                                          index] ??
                                                      ProductOptionsModel();
                                                });
                                              },
                                              buttonStyleData:
                                                  const ButtonStyleData(
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColors.kPrimaryColor,
                                                ),
                                                elevation: 0,
                                              ),
                                              iconStyleData:
                                                  const IconStyleData(
                                                icon: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    color: Colors.white,
                                                    size: 30),
                                                iconSize: 30,
                                              ),
                                              dropdownStyleData:
                                                  DropdownStyleData(
                                                      maxHeight: 150,
                                                      padding: null,
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .kTextBlackColor
                                                            .withOpacity(.9),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        14),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            14)),
                                                      ),
                                                      elevation: 0,
                                                      scrollbarTheme:
                                                          ScrollbarThemeData(
                                                        radius: const Radius
                                                            .circular(40),
                                                        thickness:
                                                            MaterialStateProperty
                                                                .all(6),
                                                        thumbVisibility:
                                                            MaterialStateProperty
                                                                .all(true),
                                                      )),
                                              // menuItemStyleData: const MenuItemStyleData(
                                              //   height: 40,
                                              //   // padding: EdgeInsets.only(left: 14, right: 14),
                                              // ),
                                            ),
                                          ),
                                        ),
                                        if (selectedOption != null &&
                                            selectedOption?.code != null)
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 15.w),

                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 5),
                                            color: AppColors.klPinkColor,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            // alignment: Alignment.center,
                                            child: Text(
                                              "${tr('codeOfSelected')} ${selectedOption?.code ?? ''}",
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                      ],
                                    )),
                          )),
                      Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 9),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.newArrival.brand?.title ?? '',
                              style: TextStyle(
                                color: const Color(0xFFDE0F7E),
                                fontSize: 16.sp,
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w600,
                                // height: 0.07,
                              ),
                            ),
                            Text(
                              widget.newArrival.title ?? '',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.sp,
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w700,
                                // height: 1,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (widget.newArrival.offerPrice != null &&
                                    widget.newArrival.offerPrice != '' &&
                                    widget.newArrival.offerPrice != '' &&
                                    widget.newArrival.offerPrice
                                            ?.split('')
                                            .first !=
                                        '0') ...{
                                  Row(
                                    children: [
                                      Text(
                                        widget.newArrival.offerPrice ?? '',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.16.sp,
                                          fontFamily: kTheArabicSansLight,
                                          fontWeight: FontWeight.w400,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          height: 0.08,
                                        ),
                                      ),
                                      Text(
                                        tr('Del'),
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10.99.sp,
                                          fontFamily: kTheArabicSansLight,
                                          fontWeight: FontWeight.w400,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ),
                                },
                                if (widget.newArrival.price != null &&
                                    widget.newArrival.price != '' &&
                                    widget.newArrival.price != '' &&
                                    widget.newArrival.price?.split('').first !=
                                        '0') ...{
                                  Row(
                                    children: [
                                      Text(
                                        widget.newArrival.price ?? '',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: const Color(0xFFDE0F7E),
                                          fontSize: 15.16.sp,
                                          fontFamily: kTheArabicSansLight,
                                          fontWeight: FontWeight.w400,
                                          height: 0.08,
                                        ),
                                      ),
                                      Text(
                                        'د.ل',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: const Color(0xFFDE0F7E),
                                          fontSize: 10.99.sp,
                                          fontFamily: kTheArabicSansLight,
                                          fontWeight: FontWeight.w400,
                                          height: 0.15,
                                        ),
                                      ),
                                    ],
                                  )
                                }
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      if ((selectedOption?.stock == null ||
                              selectedOption?.stock == "0" ||
                              num.parse(selectedOption?.stock ?? '0') < 0) &&
                          selectedOption != null) ...{
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          decoration:
                              const BoxDecoration(color: AppColors.kCDGColor),
                          child: Text(
                            tr('not_availble_now'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.11.sp,
                              fontFamily: kTheArabicSansLight,
                              fontWeight: FontWeight.w700,
                              // height: 0.09,
                            ),
                          ),
                        ),
                      } else ...{
                        InkWell(
                          onTap: () async {
                            final AuthController _controllerLogin =
                                Get.put(AuthController());
                            UserModel user = _controllerLogin.userData.value;
                            print('%%%%%%%%%:${user.id}');
                            if (user.id == null) {
                              _controllerLogin.alertOfLogin();
                              return;
                            }
                            if (selectedParentOption == null &&
                                selectedOption == null) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomAlertDialog(
                                      buttonTwo: false,
                                      dilougText: tr('chooseOptionFirst'),
                                      buttonOneText: tr('okay'),
                                    );
                                  });
                            } else {
                              await _controller.addToCart(
                                  productId: widget.newArrival.id ?? 0,
                                  productOptionId:
                                      selectedParentOption?.id ?? 0,
                                  productParentId: selectedOption?.id ?? 0);
                              await controller.getCountOfCart();
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: AppColors.kPrimaryColor),
                            child: Text(
                              tr('add_to_bags'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.11.sp,
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w700,
                                // height: 0.09,
                              ),
                            ),
                          ),
                        )
                      }
                    ],
                  )
                ],
              )
            } else ...{
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(widget.imageUrl),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    child: widget.hideLike == false
                        ? Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite
                                    ? Colors.red
                                    : const Color(0xff13110C),
                                // size: 30,
                              ),
                              onPressed: () {
                                final AuthController _controllerLogin =
                                    Get.put(AuthController());
                                UserModel user =
                                    _controllerLogin.userData.value;
                                print('%%%%%%%%%:${user.id}');
                                if (user.id == null) {
                                  _controllerLogin.alertOfLogin();
                                  return;
                                }
                                setState(() {
                                  isFavorite = true;
                                });
                                _controller.addWishlist(
                                    postId: widget.newArrival.id ?? 0);
                              },
                            ),
                          )
                        : const SizedBox(),
                  ),
                  // if (widget.newArrived == true)
                  //   Container(
                  //     margin: EdgeInsets.only(top: 10),
                  //     padding:
                  //         EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  //     color: Colors.black,
                  //     child: Text(
                  //       tr('newArrived'),
                  //       style: TextStyle(
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.w600,
                  //           fontSize: 12,
                  //           fontFamily: kTheArabicSansLight),
                  //     ),
                  //   ),
                  // if (widget.sale == true)
                  if ((widget.newArrival.labels != null) &&
                      (widget.newArrival.labels?.isNotEmpty ?? false) &&
                      widget.hideTage != true) ...{
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                          widget.newArrival.labels?.length ?? 0,
                          (index) => Container(
                                margin: EdgeInsets.only(top: 10),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                color: Color(int.parse(
                                    "ff${widget.newArrival.labels?[index].backgroundColor?.toUpperCase().replaceAll('#', '') ?? 'ffffff'}",
                                    radix: 16)),
                                child: Text(
                                  widget.newArrival.labels?[index].text ?? '',
                                  style: TextStyle(
                                      color: Color(int.parse(
                                          "ff${widget.newArrival.labels?[index].textColor?.toUpperCase().replaceAll('#', '') ?? 'ffffff'}",
                                          radix: 16)),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      fontFamily: kTheArabicSansLight),
                                ),
                              )),
                    )
                  } else if (widget.newTag != null &&
                      widget.hideTage != true) ...{
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        color: Color(int.parse(
                            "ff${widget.newTag?.backgroundColor?.toUpperCase().replaceAll('#', '') ?? 'ffffff'}",
                            radix: 16)),
                        child: Text(
                          widget.newTag?.text ?? '',
                          style: TextStyle(
                              color: Color(int.parse(
                                  "ff${widget.newTag?.textColor?.toUpperCase().replaceAll('#', '') ?? 'ffffff'}",
                                  radix: 16)),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              fontFamily: kTheArabicSansLight),
                        ))
                  },
                  if (widget.isDiscount == '1') ...{
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        color: Color(int.parse("ffde0f7e", radix: 16)),
                        child: Text(
                          'تخفيض',
                          style: TextStyle(
                              color: Color(int.parse("fffafafa", radix: 16)),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              fontFamily: kTheArabicSansLight),
                        ))
                  }
                ],
              ),
              Container(
                height: 110.h,
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: FittedBox(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(BrandDetailScreen(
                              brandId: int.parse(
                                  "${widget.newArrival.brand?.id ?? 0}"),
                            ));
                          },
                          child: Text(
                            widget.newArrival.brand?.title ?? '',
                            style: TextStyle(
                              color: const Color(0xFFDE0F7E),
                              fontSize: 15.sp,
                              fontFamily: kTheArabicSansLight,
                              fontWeight: FontWeight.w600,
                              // height: 0.07,
                            ),
                          ),
                        ),
                        Text(
                          widget.newArrival.title ?? '',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10.sp,
                            fontFamily: kTheArabicSansLight,
                            fontWeight: FontWeight.w700,
                            // height: 1,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          widget.newArrival.note ?? '',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.sp,
                            fontFamily: kTheArabicSansLight,
                            fontWeight: FontWeight.w700,
                            // height: 1,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        5.ph,
                        FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (productIsFlashDiscount != '1' &&
                                  productIsOffer != '1' &&
                                  productOptionsIsEmpty == true) ...{
                                CurrentPriceWithBlack2(
                                  price: '$productMainPrice',
                                )
                              } else if (productIsFlashDiscount != '1' &&
                                  productIsOffer == '1' &&
                                  productOptionsIsEmpty == true) ...{
                                SizedBox(
                                    width: (MediaQuery.of(context).size.width /
                                            2) -
                                        40,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          OldPriceWithBlack2(
                                            price: '$productMainPrice',
                                          ),
                                          CurrentPriceWithPink2(
                                            price: '$productOfferPrice',
                                          )
                                        ]))
                              } else if (productIsFlashDiscount == '1' &&
                                  // productIsOffer != '1' &&
                                  productOptionsIsEmpty == true) ...{
                                SizedBox(
                                    width: (MediaQuery.of(context).size.width /
                                            2) -
                                        40,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          OldPriceWithBlack2(
                                            price: '$productMainPrice',
                                          ),
                                          CurrentPriceWithPink2(
                                            price: '$productFlashDiscountPrice',
                                          )
                                        ]))
                              } else if (productIsFlashDiscount != '1' &&
                                  productIsOffer != '1' &&
                                  productOptionsIsEmpty != true) ...{
                                if (widget.newArrival.productOptions?.first
                                        .options?.first.price ==
                                    widget.newArrival.productOptions?.first
                                        .options?.last.price) ...{
                                  CurrentPriceWithBlack2(
                                    price: '$productMainPrice',
                                  ),
                                } else ...{
                                  Text(
                                    "${widget.newArrival.productOptions?.first.options?.first.price ?? ''} ${tr('Del')}-${widget.newArrival.productOptions?.first.options?.last.price ?? ''} ${tr('Del')}",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.16.sp,
                                      fontFamily: kTheArabicSansLight,
                                      fontWeight: FontWeight.w400,
                                      // decoration:
                                      // TextDecoration
                                      //     .lineThrough,
                                      height: 0.08,
                                    ),
                                  )
                                }
                              } else if (productIsFlashDiscount == '1' &&
                                  // productIsOffer != '1' &&
                                  productOptionsIsEmpty != true) ...{
                                SizedBox(
                                    width: (MediaQuery.of(context).size.width /
                                            2) -
                                        40,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          OldPriceWithBlack2(
                                            price: '$productMainPrice',
                                          ),
                                          CurrentPriceWithPink2(
                                            price:
                                                '${productFlashDiscountPrice}',
                                          )
                                        ]))
                              } else if (productIsFlashDiscount != '1' &&
                                  productIsOffer == '1' &&
                                  productOptionsIsEmpty != true) ...{
                                if (widget.newArrival.productOptions?.first
                                        .options?.first.offerPrice ==
                                    widget.newArrival.productOptions?.first
                                        .options?.last.offerPrice) ...{
                                  SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width /
                                                  2) -
                                              40,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            OldPriceWithBlack2(
                                              price: '$productMainPrice',
                                            ),
                                            CurrentPriceWithPink2(
                                              price: '${productOfferPrice}',
                                            )
                                          ]))
                                } else ...{
                                  Text(
                                    "${widget.newArrival.productOptions?.first.options?.first.offerPrice ?? ''} ${tr('Del')}-${widget.newArrival.productOptions?.first.options?.last.offerPrice ?? ''} ${tr('Del')}",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.16.sp,
                                      fontFamily: kTheArabicSansLight,
                                      fontWeight: FontWeight.w400,
                                      // decoration:
                                      // TextDecoration
                                      //     .lineThrough,
                                      height: 0.08,
                                    ),
                                  )
                                  // SizedBox()
                                }
                              } else ...{
                                Text('----')
                              }
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (widget.newArrival.stock == null ||
                  widget.newArrival.stock == "0") ...{
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.kTextDGColor.withOpacity(.5)),
                  child: Text(
                    tr('not_availble_now'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.11.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w700,
                      // height: 0.09,
                    ),
                  ),
                ),
              } else if ((widget.newArrival.stock != null &&
                      widget.newArrival.stock != "0") &&
                  (widget.newArrival.productOptions != null &&
                      widget.newArrival.productOptions?.isNotEmpty ==
                          true)) ...{
                InkWell(
                  onTap: () {
                    setState(() {
                      showProductOptions = true;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    decoration:
                        const BoxDecoration(color: AppColors.kPrimaryColor),
                    child: Text(
                      tr('choose_the_category'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.11.sp,
                        fontFamily: kTheArabicSansLight,
                        fontWeight: FontWeight.w700,
                        // height: 0.09,
                      ),
                    ),
                  ),
                ),
              } else ...{
                InkWell(
                  onTap: () async {
                    final AuthController _controllerLogin =
                        Get.put(AuthController());
                    UserModel user = _controllerLogin.userData.value;
                    print('%%%%%%%%%:${user.id}');
                    if (user.id == null) {
                      _controllerLogin.alertOfLogin();
                      return;
                    }
                    await _controller.addToCart(
                        productId: widget.newArrival.id ?? 0);
                    await controller.getCountOfCart();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    alignment: Alignment.center,
                    decoration:
                        const BoxDecoration(color: AppColors.kPrimaryColor),
                    child: Text(
                      tr('add_to_bags'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.11.sp,
                        fontFamily: kTheArabicSansLight,
                        fontWeight: FontWeight.w700,
                        // height: 0.09,
                      ),
                    ),
                  ),
                ),
              }
            }
          ],
        ),
      ),
    );
  }
}
