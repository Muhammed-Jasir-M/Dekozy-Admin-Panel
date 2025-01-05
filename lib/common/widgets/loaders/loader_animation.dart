import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/constants/image_strings.dart';

/// A circular loader widget with customizable foreground and background colors.
class ALoaderAnimation extends StatelessWidget {
  const ALoaderAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Lottie.asset(AImages.defaultLoaderAnimation, height: 200, width: 200),
    );
  }
}
