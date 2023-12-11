import 'package:beauty_queen/const/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/show_down_controller.dart';


class ItemOfApp extends StatelessWidget{
  final String title;
  final ShowDownController controller = ShowDownController();

  ItemOfApp({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          Obx(() => GestureDetector(
            onTap: () {
              controller.changeStateOfMenu();
            },
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: SizedBox(
                // height: 100,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontSize: 18),
                          ),
                          const Icon(Icons.keyboard_arrow_down_rounded)
                        ],
                      ),
                    ),
                    const Divider(),
                    if(controller.stateOfMenu.value==true)...{
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width - 20,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'بيوتي كوين ... وجهة الجمال الأولى',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontSize: 15),
                            ),
                            10.ph,
                            Text(
                              'اخترنا اسم بيوتي كوين ويعني " ملكة الجمال " وهو لفظ عام وشامل يعبر عن فحوى متجرنا فنحن نهتم بكل ما تحتاجه السيدة للعناية بجمالها وصحتها لتكون ملكة حقيقية، تتألق بإطلالتها بين الجميع بما يناسبها وحسب ميزانيتها . فخياراتنا غير محدودة',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(fontSize: 16),
                              softWrap: true,
                            ),

                            20.ph,
                            Text(
                              'بيوتي كوين الأول دائماً ...',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontSize: 15),
                            ),
                            10.ph,
                            Text(
                              'نحن نفتخر بأننا كنا السباقين في ليبيا كأول متجر توفرت Rude Cosmetics, L.A فيه ماركات عالمية معروفة مثل girl, L.A colors, Nascita, Makeup Atelier, Plouise وذلك قبل أن تنتشر في Academy, No7, Fancy Look السوق الليبي ، و لا زلنا حتى يومنا هذا نتفرد بتوفير منتجات حصرية يصعب ان تتواجد باستمرار في السوق الليبي .. انه تحدي كبير .. هناك دائماً الجديد .. و الرائج .. و المختلف .. ولهذا نسعى دائماً لأنه نكون من الأوائل في توفير كل ما يهم جمال المرأة',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(fontSize: 16),
                              softWrap: true,
                            ),
                            20.ph,
                            Text(
                              'ثقة العملاء من اهم اولوياتنا ...',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontSize: 15),
                            ),
                            10.ph,
                            Text(
                              'بناء جسور الثقة مع عملائنا هو عنصر النجاح الأول الذي سعينا لبنائه من اليوم الأول لانطلاق متجرنا .. ولا زلنا نحرص على تعزيز اواصر الثقة مع كل عملاءنا.. بداية من توفير المنتجات الاصلية من مصادر موثوقة بحيث يتم استيرادها في ظروف مناسبة وتخزينها بالشكل المثالي حتى تصل لعملائنا في الصورة التي يمكنهم بها استخدامها بكل أمان وثقة ، فضلاً عن هذا فإننا نهتم دائماً بملاحظات العملاء وطلباتهم بخصوص عيوب التصنيع او مشاكل الشحن ونقدم لهم التعويض المناسب ... فرضاء الزبون وثقته هي اولوية لا نقبل المساومة عليها.',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(fontSize: 16),
                              softWrap: true,
                            ),
                          ],
                        ),
                      )
                    }
                  ],
                ),
              ),
            ),
          )),
          // 10.ph
        ],
      );
  }

}