import 'package:flutter/material.dart';

class StudentCounter {
  static ValueNotifier<int> count = ValueNotifier<int>(0);
  static ValueNotifier<int> boys = ValueNotifier<int>(0);
  static ValueNotifier<int> girls = ValueNotifier<int>(0);
  static ValueNotifier<Map<String, int>> classCounts = ValueNotifier({
    for (int i = 1; i <= 12; i++) 'Class $i': 0,
  });

  static void increment(String gender) {
    if (gender == 'Male') {
      boys.value++;
    } else if (gender == 'Female') {
      girls.value++;
    }
  }
}
