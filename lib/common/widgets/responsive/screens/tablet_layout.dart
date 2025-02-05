import 'package:aura_kart_admin_panel/common/widgets/layouts/headers/headers.dart';
import 'package:flutter/material.dart';
import 'package:aura_kart_admin_panel/common/widgets/layouts/sidebars/sidebar.dart';

class TabletLayout extends StatelessWidget {
  TabletLayout({super.key, this.body});

  final Widget? body;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const ASidebar(),
      appBar: AHeader(scaffoldKey: scaffoldKey),
      body: body ?? const SizedBox(),
    );
  }
}
