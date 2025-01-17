import 'package:aura_kart_admin_panel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class ATableHeader extends StatelessWidget {
  const ATableHeader({
    super.key,
    this.onPressed,
    required this.buttonText,
    this.searchController,
    this.searchOnChanged,
  });

  final Function()? onPressed;
  final String buttonText;
import 'package:iconsax/iconsax.dart';

class ATableHeader extends StatelessWidget {
  const ATableHeader(
      {super.key,
      this.onPressed,
      required this.buttonText,
      this.searchController,
      this.searchOnChanged});
  final Function()? onPressed;
  final String buttonText;

  final TextEditingController? searchController;
  final Function(String)? searchOnChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: ADeviceUtils.isDesktopScreen(context) ? 3 : 1,
          flex: !ADeviceUtils.isDesktopScreen(context) ? 3 : 1,
          child: Row(
            children: [
              SizedBox(
                width: 200,
                child: ElevatedButton(
                    onPressed: onPressed, child: Text(buttonText)),
              )
            ],
          ),
        ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: ADeviceUtils.isDesktopScreen(context) ? 2 : 1,
          child: TextFormField(
            controller: searchController,
            onChanged: searchOnChanged,
            decoration: const InputDecoration(
                hintText: 'Search Here...',
                prefixIcon: Icon(Iconsax.search_normal)),
          ),
        ),
      ],
    );
  }
}
