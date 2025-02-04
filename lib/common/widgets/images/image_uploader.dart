import 'dart:typed_data';

import 'package:aura_kart_admin_panel/common/widgets/images/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../icons/circular_icon.dart';
import '../../../../../../common/widgets/images/circular_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';

/// Widget for uploading images with optional editing functionality
class AImageUploader extends StatelessWidget {
  const AImageUploader({
    super.key,
    this.image,
    this.onIconButtonPressed,
    this.memoryImage,
    this.width = 100,
    this.height = 100,
    required this.imageType,
    this.circular = false,
    this.icon = Iconsax.edit_2,
    this.top,
    this.bottom = 0,
    this.right,
    this.left = 0,
  });

  /// Whether to display the image in a circular shape
  final bool circular;

  /// URL or path of the image to display
  final String? image;

  /// Type of image (network, asset, memory, etc.)
  final ImageType imageType;

  /// Width of the image uploader widget
  final double width;

  /// Height of the image uploader widget
  final double height;

  /// Byte data of the image (for memory images)
  final Uint8List? memoryImage;

  /// Icon to display on the image uploader widget
  final IconData icon;

  /// Offset from the top edge of the widget
  final double? top;

  /// Offset from the bottom edge of the widget
  final double? bottom;

  /// Offset from the right edge of the widget
  final double? right;

  /// Offset from the left edge of the widget
  final double? left;

  /// Callback function for when the icon button is pressed
  final void Function()? onIconButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Display the image in either circular or rounded shape
        circular
            ? ACircularImage(
                image: image,
                width: width,
                height: height,
                imageType: imageType,
                memoryImage: memoryImage,
                backgroundColor: AColors.primaryBackground,
              )
            : ARoundedImage(
                image: image,
                width: width,
                height: height,
                imageType: imageType,
                memoryImage: memoryImage,
                backgroundColor: AColors.primaryBackground,
                padding: 1,
              ),
        // Display the edit icon button on top of the image
        Positioned(
          top: top,
          left: left,
          right: right,
          bottom: bottom,
          child: ACircularIcon(
            icon: icon,
            size: ASizes.md,
            color: Colors.white,
            onPressed: onIconButtonPressed,
            backgroundColor: AColors.primary.withValues(alpha: 0.9),
          ),
        )
      ],
    );
  }
}
