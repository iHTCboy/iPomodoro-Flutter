import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertView {
  static Future<bool> show(BuildContext context, String title, String content,
      {String cancelText='', String confirmText='OK',
        Color cancelTextColor=Colors.blue, Color confirmTextColor=Colors.red }) async {

    List<Widget> actions = [];
    if(cancelText.isNotEmpty) {
      actions.add(CupertinoButton(
        //不能用IconButton
          child: Text(cancelText,
            style: TextStyle(
              color: cancelTextColor,
            ),),
          onPressed: () {
            Navigator.pop(context, false); //要自己dismiss
          }));
    }
    if(confirmText.isNotEmpty) {
      actions.add(CupertinoButton(
          child: Text(confirmText,
            style: TextStyle(
              color: confirmTextColor,
            ),
          ),
          onPressed: () {
            Navigator.pop(context, true);
          }));
    }

    bool ans = await showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
              title: Text(title),
              content: Text(content),
              actions: actions);
        });
    return ans;
  }
}