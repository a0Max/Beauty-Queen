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
                  UniVars.openTheLink(
                      isLink: isLink,
                      linkType: linkType,
                      urlLink: urlLink,
                      linkId: linkId);
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
