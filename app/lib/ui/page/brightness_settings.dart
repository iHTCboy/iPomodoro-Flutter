import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iPomodoro/common/channel/native_method_channel.dart';
import 'package:iPomodoro/common/constant/app_colors.dart';
import 'package:iPomodoro/generated/l10n.dart';

class BrightnessSettings extends StatefulWidget {
  @override
  _BrightnessSettingsState createState() => _BrightnessSettingsState();
}

class _BrightnessSettingsState extends State<BrightnessSettings> {

  double _sliderValue = 0.0;

  @override
  void initState() {
    super.initState();
    NativeChannel.changeBrightness("0.5", getBrightness: "1").then((value) {
      if (value != null) {
        setState(() {
          _sliderValue = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).set_screen_brightness),
        backgroundColor: AppColors.ME_SUB_COLOR, systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(Icons.lightbulb_outline, color: Colors.grey,),
            Expanded(
              child: Slider(
                value: _sliderValue,
                onChanged: (data) {
                  // print('change:$data');
                  setState(() {
                    _sliderValue = data;
                  });
                },
                onChangeStart: (data) {
                  // print('start:$data');
                },
                onChangeEnd: (data) {
                  // print('end:$data');
                  NativeChannel.changeBrightness(data.toStringAsFixed(1));
                },
                min: 0.0,
                max: 1.0,
                divisions: 10,
                label: '${_sliderValue.toStringAsFixed(1)}',
                activeColor: Colors.green,
                inactiveColor: Colors.grey,
              ),
            ),
            Icon(Icons.lightbulb, color: Colors.amber,),
          ],
        ),
      ),
    );
  }
}