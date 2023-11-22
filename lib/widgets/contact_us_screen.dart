import 'package:beauty_queen/const/extensions.dart';
import '../const/app_images.dart';
import 'package:flutter/material.dart';


class ContactUsScreen extends StatelessWidget{
  const ContactUsScreen({super.key});

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
                  AppImages.imagePhoneCall,
                  height: 20,
                  width: 20,
                )),
            10.pw,
            Text(
              'اتصل بنا',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
        10.ph,
        Text('رقم المتجر 0919900224', style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 15, fontWeight: FontWeight.w600),),
        5.ph,
        Text('رقم خدمة العملاء 0928225378', style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 15, fontWeight: FontWeight.w600),),
        15.ph,
        Text('*جاهزين الاستقبال مكالماتكم من الساعة 11 صباحاً حتى الساعة 4 مساءاً', style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.w200),),

      ],
    );
  }

}