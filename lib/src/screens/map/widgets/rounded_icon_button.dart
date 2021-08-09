import 'package:courses_example_project/src/constants/color_const.dart';
import 'package:flutter/cupertino.dart';

class RoundedIconButton extends StatelessWidget {
  const RoundedIconButton({
    Key? key,
    required this.icon,
  }) : super(key: key);

  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(360),
      child: CupertinoButton(
        minSize: 0,
        padding: const EdgeInsets.all(10),
        onPressed: () async {},
        color: AppColors.white,
        child: icon,
      ),
    );
  }
}
