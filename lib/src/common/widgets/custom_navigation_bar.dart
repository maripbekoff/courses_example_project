import 'package:flutter/cupertino.dart';

import 'custom_back_arrow_widget.dart';

class CustomNavigationBar extends StatelessWidget
    with ObstructingPreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final Widget? trailing;
  final Color? backgroundColor;

  const CustomNavigationBar({
    Key? key,
    @required this.title,
    this.leading = const CustomBackArrow(),
    this.trailing,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Size get preferredSize =>
      const Size.fromHeight(kMinInteractiveDimensionCupertino);

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      backgroundColor: backgroundColor,
      padding: EdgeInsetsDirectional.zero,
      leading: leading,
      middle: Text(title ?? ''),
      border: Border(),
      trailing: trailing,
    );
  }
}
