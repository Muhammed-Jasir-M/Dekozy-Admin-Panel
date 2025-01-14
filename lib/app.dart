import 'package:aura_kart_admin_panel/routes/app_routes.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'utils/constants/colors.dart';
import 'utils/constants/text_strings.dart';
import 'utils/device/web_material_scroll.dart';
import 'utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: ATexts.appName,
      themeMode: ThemeMode.light,
      theme: AAppTheme.lightTheme,
      darkTheme: AAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      initialRoute: ARoutes.dashboard,
      getPages: AAppRoutes.pages,
      unknownRoute: GetPage(
        name: '/page-not-found',
        page: () => const Scaffold(body: Center(child: Text('Page Not Found'))),
      ),
      home: const Scaffold(
        backgroundColor: AColors.primary,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      ),
    );
  }
}
