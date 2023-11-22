import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownWidget extends StatefulWidget {
  const CustomDropDownWidget({Key? key}) : super(key: key);

  @override
  State<CustomDropDownWidget> createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {
  bool isExpanded = false;
  String selectedValue = 'Select option';

  //list that will be expanded
  List<String> politicsList = [
    'Left Wing',
    'Liberal',
    'Moderate',
    'Conservative',
    'Libertarian',
    'Apolitical'
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Container(
        width: 199.w,
        height: 39.76.h,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(5),
            topRight: const Radius.circular(5),
            bottomLeft: Radius.circular(isExpanded ? 0 : 5),
            bottomRight: Radius.circular(isExpanded ? 0 : 5),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  isExpanded = !isExpanded;
                  setState(() {});
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(selectedValue,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontSize: 16))),
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: isExpanded ? Colors.red : Colors.blue,
                    )
                  ],
                )),
          ),
        ),
      ),
      if (isExpanded)
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: politicsList
              .map((e) => InkWell(
                    onTap: () {
                      isExpanded = false;
                      selectedValue = e;
                      setState(() {});
                    },
                    child: Container(
                        height: 39.h,
                        width: 199.w,
                        decoration: BoxDecoration(
                          color: selectedValue == e
                              ? Colors.pink
                              : Colors.grey.shade300,
                        ),
                        child: Center(
                            child: Text(
                          e.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  fontSize: 14,
                                  color: selectedValue == e
                                      ? Colors.black
                                      : Colors.blue),
                        ))),
                  ))
              .toList(),
        )
    ]));
  }
}
