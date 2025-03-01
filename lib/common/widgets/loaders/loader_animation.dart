import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';


import '../../../utils/constants/image_strings.dart';

/// A circular loader widget with customizable foreground and background colors.
class ALoaderAnimation extends StatelessWidget {
  const ALoaderAnimation({
    super.key,
    this.height = 300,
    this.width = 300,
  });

  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child:Column(
        children: [
          Image(image: const AssetImage(AImages.ridingIllustraton), height: height, width: width),
          const SizedBox(height: ASizes   .spaceBtwItems),
          const Text('Loading your data....'),
        ],
      )
        
    );
  }
}
