import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:flutter/material.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key, this.body});

  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: Row(
        children: [
          const Expanded(child: Drawer()),
          Expanded(
            child: Column(
              children: [
                // Header
                ARoundedContainer(
                  width: double.infinity,
                  height: 70,
                  backgroundColor: Colors.yellow,
                ),

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
