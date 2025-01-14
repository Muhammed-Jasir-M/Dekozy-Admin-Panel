import 'package:aura_kart_admin_panel/data/repositories/authentication/authentication_repository.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ARoutesMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return AuthenticationRepository.instance.isAuthenticated
        ? null
        : RouteSettings(name: ARoutes.login);
  }
}
