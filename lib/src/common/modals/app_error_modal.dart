import 'package:flutter/cupertino.dart';

class AppErrorModal extends StatelessWidget {
  const AppErrorModal({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Ошибка'),
      content: Text(message),
      actions: [
        CupertinoButton(
          child: Text('ОК'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
