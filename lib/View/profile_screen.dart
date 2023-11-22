
import 'package:beauty_queen/const/extensions.dart';
import 'package:flutter/material.dart';

import '../widgets/contact_us_screen.dart';
import '../widgets/location_map.dart';
import 'about_app.dart';
import '../widgets/comment_widget.dart';
import '../widgets/email_widget.dart';
import '../widgets/social_login.dart';
import '../widgets/text_field_widget.dart';
import '../widgets/work_hours.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: SizedBox(),
        actions: [
          IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: const Icon(                Icons.arrow_forward_ios,
          ))
        ],

        title: Text(
          'تواصل معنا',
          style:
              Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
          child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.ph,
              const ContactUsScreen(),
              25.ph,
              const SocialLogin(),
              25.ph,
              const EmailWidget(),
              25.ph,
              const CommentWidget(),
              25.ph,
              const WorkHours(),
              25.ph,
              LocationMap()

            ],
          ),
        ),
      )),
    );
  }
}
