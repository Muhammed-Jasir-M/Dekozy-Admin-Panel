import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/layouts/headers/sidebars/sidebar.dart';
import 'package:flutter/material.dart';

class DesktopLayout extends StatelessWidget {
   DesktopLayout({super.key, this.body});

  final Widget? body;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(),
      body: Row(
        children: [
          const Expanded(child: ASidebar()),
          Expanded(
            child: Column(
              children: [
                // Header
                const AHeader(),

                // Body
                body ?? SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
