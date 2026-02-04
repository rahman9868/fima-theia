import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../navigation/global_navigator.dart';

class NavigationService extends GetxService {
  static NavigationService get to => Get.find();
  
  final GlobalKey<NavigatorState> navigatorKey = globalNavigatorKey;

  Future<NavigationService> init() async {
    return this;
  }

  void navigateToLogin() {
    if (navigatorKey.currentContext != null) {
      navigatorKey.currentContext!.go('/');
    }
  }
}