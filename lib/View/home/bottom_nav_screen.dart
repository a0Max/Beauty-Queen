import 'package:beauty_queen/View/gifts/GuidanceScreen.dart';
import 'package:beauty_queen/View/home/HomePage.dart';
import 'package:beauty_queen/controller/nav_bar_controller/NavBarController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/AlKasam_controller/alkasam_controller.dart';
import '../../widgets/home/CustomNavBar.dart';
import '../categories/alkasam_screen.dart';
import '../brands/brands_screen.dart';
import '../discount/discounts_screen.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainView();
  }
}

class _MainView extends State<MainView> {
  final AlkasamController controller2 = Get.put(AlkasamController());
  final NavController controller = Get.put(NavController());

  @override
  void initState() {
    super.initState();
    controller2.getAlkasamDataController();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomePage(),
      const AlKasamScreen(),
      const DiscountScreen(),
      const BrandScreen(),
      const GuidanceScreen()
    ];
    controller.getCountOfCart();
    return Scaffold(
      body: Obx(() => screens[controller.currentIndex.value]),
      bottomNavigationBar: const ReusableBottomNavigationBar(),
    );
  }
}
