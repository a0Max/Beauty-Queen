import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/vars.dart';

class DialogWidget extends StatelessWidget {
  final String image;

  const DialogWidget({super.key, required this.image});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Stack(
        children: [
          CachedNetworkImage(imageUrl: Connection.urlOfStorage(image: image)),
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ))
        ],
      ),
    );
  }
}
