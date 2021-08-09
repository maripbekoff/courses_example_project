import 'package:flutter/cupertino.dart';

class CustomBackArrow extends StatelessWidget {
  const CustomBackArrow({
    Key? key,
    this.onPressed,
    this.color = CupertinoColors.black,
  }) : super(key: key);

  final Function? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Icon(
        CupertinoIcons.back,
        size: 26,
        color: color,
      ),
      onPressed: () {
        onPressed?.call();
        Navigator.maybePop(context);
      },
    );
  }
}
