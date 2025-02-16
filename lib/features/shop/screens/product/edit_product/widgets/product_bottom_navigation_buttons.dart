import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/sizes.dart';

class ProductBottomNavigationButtons extends StatelessWidget {
  const ProductBottomNavigationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return ARoundedContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Discard Button
          OutlinedButton(onPressed: () {}, child: const Text('Discard')),
          const SizedBox(width: ASizes.spaceBtwItems /2),

          // Save Changes Button
          SizedBox(
            width: 160,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Save Changes'),
            ),
          ),
        ],
      ),
    );
  }
}
