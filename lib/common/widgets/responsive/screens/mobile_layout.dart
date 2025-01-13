import 'package:aura_kart_admin_panel/common/widgets/layouts/headers/headers.dart';
import 'package:aura_kart_admin_panel/common/widgets/layouts/headers/sidebars/sidebar.dart';
import 'package:flutter/material.dart';

class MobileLayout extends StatelessWidget {
   MobileLayout({super.key, this.body});

  final Widget? body;
  final GlobalKey<ScaffoldState> scaffold = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const ASidebar(),
      appBar: AHeader(scaffoldKey: scaffoldKey),
      body: body ?? Container(),
    );
  }
}
 