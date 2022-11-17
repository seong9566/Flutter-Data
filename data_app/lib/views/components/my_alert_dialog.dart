import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog({required this.msg, Key? key}) : super(key: key);
  final String msg;
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text("${msg}"),
      // ignore: prefer_const_literals_to_create_immutables
      actions: [
        CupertinoDialogAction(
          child: Text("확인"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
