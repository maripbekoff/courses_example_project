import 'package:courses_example_project/src/constants/color_const.dart';
import 'package:flutter/cupertino.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.placeholder = 'Введите',
    this.suffix,
    this.controller,
    this.obscureText = false,
    this.prefix,
    this.borderRadius,
    this.backgroundColor = CupertinoColors.white,
    this.border,
    this.padding = const EdgeInsets.symmetric(vertical: 19, horizontal: 16),
  }) : super(key: key);

  final String placeholder;
  final Widget? suffix;
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? prefix;
  final BorderRadiusGeometry? borderRadius;
  final Color backgroundColor;
  final BoxBorder? border;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      placeholder: placeholder,
      placeholderStyle: TextStyle(
        color: AppColors.inActive,
      ),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: backgroundColor,
        border: border,
      ),
      obscureText: obscureText,
      prefix: prefix,
      padding: padding,
      suffix: suffix,
    );
  }
}
