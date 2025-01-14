import 'package:aura_kart_admin_panel/common/widgets/layouts/headers/headers.dart';
import 'package:aura_kart_admin_panel/common/widgets/layouts/headers/sidebars/sidebar.dart';
import 'package:flutter/material.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key, this.body});

  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Expanded(child: ASidebar()),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                // Header
                const AHeader(),

                // Body
                Expanded(child: body ?? const SizedBox()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
