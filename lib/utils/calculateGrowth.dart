
import 'package:flutter/material.dart';

calculateGrowthPercentage(int currentData, int previousData) {
  return (100 - (currentData / previousData * 100));
}
Icon showGrowthIcon(int currentData, int previousData) {
  Icon icon;
  if(currentData > previousData) {
    icon = Icon(Icons.arrow_upward, color: Colors.green,);
  } else {
    icon = Icon(Icons.arrow_downward, color: Colors.red,);
  }
  return icon;
}
Color showGrowthColor(int currentData, int previousData) {
  Color color;
  if(currentData > previousData) {
    color = Colors.green;
  } else {
    color = Colors.red;
  }
  return color;
}