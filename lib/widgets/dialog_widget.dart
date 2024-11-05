import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../View/brands/branddetail_screen.dart';
import '../View/categories/filter_screen2.dart';
import '../View/product_profile/products_screen.dart';
import '../View/search/search_screen.dart';
import '../const/vars.dart';
import '../controller/AlKasam_controller/alkasam_controller.dart';
import '../controller/auth_controller/auth_controler.dart';
import '../controller/product_controller/product_profile_controller_provider.dart';
import '../models/user_model.dart';

class DialogWidget extends StatelessWidget {
  final String image;
  final String? isLink;
  final String? linkType;
  final String? linkId;
  final String? urlLink;
  final void Function() onPressBack;

  const DialogWidget(
      {super.key,
      required this.image,
      this.isLink,
      this.linkType,
      required this.onPressBack,
      this.urlLink,
      this.linkId});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Stack(
          children: [
            GestureDetector(
                onTap: () async {
                  final AuthController _controllerLogin =
                      Get.put(AuthController());
                  UserModel user = _controllerLogin.userData.value;
                  print(
                      '%%%%%%%%%:$linkType -${(linkType == LinkTypes.product)}');
                  print('%%%%%%%%%:$linkId');
                  print('%%%%%%%%%:$isLink');
                  if (user.id == null) {
                    _controllerLogin.alertOfLogin();
                    return;
                  }
                  if (isLink == "1") {
                    if (linkType == LinkTypes.brand) {
                      Get.to(BrandDetailScreen(
                        brandId: int.parse(linkId ?? ''),
                      ));
                    } else if (linkType == LinkTypes.product) {
                      Get.to(ChangeNotifierProvider(
                          create: (context) =>
                              ProductProfileControllerProvider(),
                          child: ItemProfilePage(
                            itemId: int.parse(linkId ?? ''),
                            doNotShowDialog: true,
                          )));
                    } else if (linkType == LinkTypes.category) {
                      AlkasamController controller =
                          Get.put(AlkasamController());
                      controller.updateCurrentCategoryId(
                          newId: int.parse(linkId ?? ''), getChild: null);
                      Get.to(FliterScreen2(
                        categoryId: int.parse(linkId ?? ''),
                      ));
                    } else {
                      try {
                        List linkData = urlLink.toString().split("/") ?? [];
                        if (linkData[1] == LinkTypes.search) {
                          String searchWord =
                              linkData[2].replaceAll('%20', ' ');
                          print('searchWord:$searchWord');
                          Get.to(() => SearchScreen(
                              subKeyWord: searchWord, doNotShowDialog: true));
                        } else {
                          Uri _url = Uri.parse('https://${urlLink}');
                          await launchUrl(
                            _url,
                            mode: LaunchMode.externalApplication,
                          );
                        }
                      } catch (e, s) {
                        Uri _url = Uri.parse('https://$urlLink');
                        await launchUrl(
                          _url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    }
                  }
                },
                child: CachedNetworkImage(
                    imageUrl: Connection.urlOfStorage(image: image))),
            IconButton(
                onPressed: () => onPressBack(),
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                ))
          ],
        ),
      ),
    );
  }
}
