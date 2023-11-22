import 'package:beauty_queen/View/GuidanceScreen.dart';
import 'package:beauty_queen/View/HomePage.dart';
import 'package:beauty_queen/controller/NavBarController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/CustomNavBar.dart';
import 'alkasam_screen.dart';
import 'brands_screen.dart';
import 'discounts_screen.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final NavController controller = Get.put(NavController());
    final List<Widget> screens = [
      const HomePage(),
      const AlKasamScreen(),
      const DiscountScreen(),
      const BrandScreen(),
      const GuidanceScreen()
    ];

    return Scaffold(
      body: Obx(() => screens[controller.currentIndex.value]),
      bottomNavigationBar: const ReusableBottomNavigationBar(),
    );
  }
}
