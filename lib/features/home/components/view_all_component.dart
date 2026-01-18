import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/features/home/categories_screen.dart';
import 'package:news_app/features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';

class ViewAllComponent extends StatelessWidget {
  const ViewAllComponent({
    super.key,
    required this.title,
    this.color,
    required this.onTap,
  });

  final String title;
  final Color? color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.pw16,
        vertical: AppSizes.ph8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: AppSizes.sp18,
              fontWeight: FontWeight.w700,
              color: color ?? Colors.white,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return ChangeNotifierProvider.value(
                      value: context.read<HomeController>(),
                      child: CategoriesScreen(),
                    );
                  },
                ),
              );
            },
            child: Text(
              'View all',
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: color ?? Colors.white,
                fontSize: AppSizes.sp14,
                fontWeight: FontWeight.w400,
                color: color ?? Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
