import 'package:aura_kart_admin_panel/common/widgets/layouts/sidebars/sidebar_controller.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteObserver extends GetObserver {
  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    final sidebarController = Get.put(SidebarController());

    if (previousRoute != null) {
      for (var routeName in ARoutes.sidebarMenuItems) {
        if (previousRoute.settings.name == routeName) {
          sidebarController.activeItem.value = routeName;
        }
      }
    }
  }
}
