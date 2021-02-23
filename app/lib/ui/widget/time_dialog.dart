import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeDialog extends Dialog {

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: 340,
          height: 250,
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Align(
                      child: Text('选择时间'),
                      alignment: Alignment.center,
                    ),
                    Align(
                      child: InkWell(
                        child: Icon(Icons.close),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      alignment: Alignment.topRight,
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text('test'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class TimerPicker {

  Future<Duration> show(BuildContext context, int hours, int minutes, onTimerDurationChanged(Duration duration)) async {
    Duration durationTime = await showModalBottomSheet<Duration>(
      enableDrag: false,
      isDismissible: false,
      context: context,
      builder: (context) {
        Duration oldDuration =
        Duration(hours: hours, minutes: minutes);
        Duration tempDuration = oldDuration;
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('取消'),
                      onPressed: () {
                        Navigator.of(context).pop(oldDuration);
                      },
                    ),
                    CupertinoButton(
                      child: Text('确认'),
                      onPressed: () {
                        Navigator.of(context).pop(tempDuration);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoTimerPicker(
                    mode: CupertinoTimerPickerMode.hm,
                    initialTimerDuration: tempDuration,
                    onTimerDurationChanged: (Duration duration) {
                      tempDuration = duration;
                      onTimerDurationChanged(duration);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    return durationTime;
  }
}

class DatePicker {

  Future<DateTime> show(BuildContext context, DateTime time,  CupertinoDatePickerMode mode, onDateTimeChanged(DateTime dateTime)) async {
    DateTime durationTime = await showModalBottomSheet<DateTime>(
      enableDrag: false,
      isDismissible: false,
      context: context,
      builder: (context) {
        DateTime oldDuration = time;
        DateTime tempDuration = oldDuration;
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('取消'),
                      onPressed: () {
                        Navigator.of(context).pop(oldDuration);
                      },
                    ),
                    CupertinoButton(
                      child: Text('确认'),
                      onPressed: () {
                        Navigator.of(context).pop(tempDuration);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    mode: mode,
                    minimumYear: 1900,
                    maximumYear: 2999,
                    use24hFormat: true,
                    initialDateTime: time,
                    onDateTimeChanged: (DateTime date) {
                      tempDuration = date;
                      onDateTimeChanged(date);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    return durationTime;
  }

}