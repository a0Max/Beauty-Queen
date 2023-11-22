import 'package:flutter/material.dart';
import 'package:beauty_queen/const/extensions.dart';
import '../const/app_images.dart';

class SocialLogin extends StatelessWidget{
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Transform.flip(
                flipX: true,
                child: Image.asset(
                  AppImages.imagesInternet,
                  height: 30,
                  width: 30,
                )),
            10.pw,
            Text(
              'حساباتنا على السوشل ميديا',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
        10.ph,
        Row(
          children: List.generate(4, (index) => Container(
            margin: const EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black
            ),
            width: 40,
            height: 40,
          )),
        ),

      ],
    );
  }

}