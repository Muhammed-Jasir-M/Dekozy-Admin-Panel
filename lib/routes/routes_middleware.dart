import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ARoutesMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    print('..................MiddleWare Called...................');
    final isAuthenticated = false;
    return isAuthenticated ? null : const RouteSettings(name: ARoutes.login);
  }
}
