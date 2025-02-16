import 'package:aura_kart_admin_panel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ATableHeader extends StatelessWidget {
  const ATableHeader({
    super.key,
    this.onPressed,
    this.buttonText = 'Add',
    this.searchController,
    this.searchOnChanged,
    this.showLeftWidget = true,
  });

  final Function()? onPressed;
  final String buttonText;
  final bool showLeftWidget;
  final TextEditingController? searchController;
  final Function(String)? searchOnChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: ADeviceUtils.isDesktopScreen(context) ? 3 : 1,
          child: showLeftWidget
              ? Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: onPressed,
                        child: Text(buttonText),
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
        Expanded(
          flex: ADeviceUtils.isDesktopScreen(context) ? 2 : 1,
          child: TextFormField(
            controller: searchController,
            onChanged: searchOnChanged,
            decoration: const InputDecoration(
              hintText: 'Search here...',
              prefixIcon: Icon(Iconsax.search_normal),
            ),
          ),
        ),
      ],
    );
  }
}
