import 'package:aura_kart_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/data_table/table_header.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/customer/all_customers/table/data_table.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomersMobileScreen extends StatelessWidget {
  const CustomersMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //BreadCrumb
              ABreadcrumbsWithHeading(
                  heading: 'Customer', breadcrumbItems: ['Customers']),
              ARoundedContainer(
                child: Column(
                  children: [
                    //Table Header
                    ATableHeader(
                      showLeftWidget: false,
                    ),
                    SizedBox(height: ASizes.spaceBtwItems),
                    //Table
                    CustomerTable(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
