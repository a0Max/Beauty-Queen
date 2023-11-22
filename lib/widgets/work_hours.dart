import 'package:beauty_queen/const/extensions.dart';
import 'package:flutter/material.dart';

import '../const/app_images.dart';

class WorkHours extends StatelessWidget{
  const WorkHours({super.key});

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
                  AppImages.imageClock,
                  height: 30,
                  width: 30,
                )),
            10.pw,
            Text(
              'ساعات العمل',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
        15.ph,
        Text('كل أيام الأسبوع من الساعة 10 صباحاً إلى الساعة 8:30 مساءاً', style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.w200),),
        Text(' يوم الجمعة من الساعة 4 بعد الظهر إلى الساعة 8.300 مساءً', style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.w200),),

      ],
    );
  }

}