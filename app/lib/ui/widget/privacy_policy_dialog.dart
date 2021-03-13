import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iPomodoro/generated/l10n.dart';

class PrivacyPolicyDialog {
  void showCustomDialog(BuildContext context,
      {@required Function textClickedFunction,
      @required Function cancelBtnFunction,
      @required Function agreeBtnFunction}) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Material(
            type: MaterialType.transparency,
            child: Center(
                child: Container(
              padding: EdgeInsets.all(15),
              width: 280,
              height: 300,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 10),
                        blurRadius: 10),
                  ]),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    "assets/images/app_logo.png",
                    width: 50,
                    height: 50,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    S.of(context).tips_text,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        decoration: TextDecoration.none),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: textClickedFunction,
                    child: Text(
                      S.of(context).privacy_policy_tips,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            cancelBtnFunction();
                          },
                          child: Text(
                            S.of(context).privacy_policy_reject,
                            style: TextStyle(fontSize: 16, color: Colors.green),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            agreeBtnFunction();
                          },
                          child: Text(
                            S.of(context).privacy_policy_agree,
                            style: TextStyle(fontSize: 16),
                          )),
                    ],
                  ),
                ],
              ),
            )),
          );
        });
  }
}
