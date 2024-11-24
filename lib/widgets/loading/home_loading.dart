import 'package:flutter/material.dart';

import '../shimmer/shimmer_categories.dart';
import '../shimmer/shimmer_new_arrivals.dart';
import '../shimmer/shimmer_new_items.dart';
import '../shimmer/shimmer_slider.dart';

Column homeLoading(){
  return  const Column(
    children: [
      ShimmerSlider(),
      ShimmerCategories(),
      ShimmerNewItems(),
      ShimmerNewArrivals()
    ],
  );
}