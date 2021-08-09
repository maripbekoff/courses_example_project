import 'package:courses_example_project/src/constants/border_radius_const.dart';
import 'package:courses_example_project/src/constants/color_const.dart';
import 'package:flutter/cupertino.dart';

import 'custom_text_field.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    Key? key,
    this.backgroundColor = const Color(0),
  }) : super(key: key);

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      prefix: CupertinoButton(
        onPressed: () {},
        padding: EdgeInsets.zero,
        child: Icon(
          CupertinoIcons.search,
          color: AppColors.inActive,
        ),
      ),
      placeholder: 'Поиск',
      borderRadius: AppBorderRadius.primary,
      backgroundColor: backgroundColor,
      border: Border.all(
        color: AppColors.stroke,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 12,
      ),
    );
  }
}
