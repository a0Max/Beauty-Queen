import 'package:beauty_queen/const/extensions.dart';
import '../const/app_images.dart';
import 'package:flutter/material.dart';

import 'button_widget.dart';
import 'text_field_widget.dart';

class CommentWidget extends StatelessWidget{
  const CommentWidget({super.key});

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
                  AppImages.imageLove,
                  height: 30,
                  width: 30,
                )),
            10.pw,
            Text(
              'اقتراحاتكم واستفساراتكم',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
        10.ph,
        const TextFieldWidget(maxLinesInt: 5,borderRadius:2,maxLength: 50,),
        Text('*يرجي إدخال 50 كلمة كحد أقصيً', style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.w200),),
        10.ph,
        Text('رقم الهاتف', style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 15, fontWeight: FontWeight.w600),),
        10.ph,
        const Row(
          children: [
            Expanded(flex: 2,child: TextFieldWidget(borderRadius:2, height: 40,)),
            Expanded(flex: 1,child: SizedBox()),
          ],
        ),
        SizedBox(
          width: 140,
          height: 75,
          child: ButtonWidget(
            textColor: Colors.white,
            boarderColor: Theme.of(context).primaryColor,
            text: 'إرسال',
            marginHeight: 15,
            paddingVertical: 0,
            marginWidth: 0,
            action: () {
            },
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
      ],

    );
  }

}