import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class DeviceUtils {
  static double get_size(
      BuildContext context, double small, double normal, double pad) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isSmall = width < 400 || height < 400;
    bool isPad = (width > 480 && height > 1000) || ((height > 480 && width > 1000));
    return isSmall ? small : (isPad ? pad : normal);
  }

  static double scale_width(
      BuildContext context, double small, double normal, double pad) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if(width > height) {
      width = height;
    }
    return width * get_size(context, small, normal, pad);
  }

  static double scale_height(
      BuildContext context, double small, double normal, double pad) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if(width > height) {
      height = width;
    }
    return height * get_size(context, small, normal, pad);
  }

  static String languageCode() {
    String languageCode = Platform.localeName.split('_')[0];
    return languageCode;
  }

  static String countryCode() {
    String countryCode = Platform.localeName.split('_')[1];
    return countryCode;
  }
}
