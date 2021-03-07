import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iPomodoro/common/constant/app_colors.dart';
import 'package:iPomodoro/common/utils/device_utils.dart';
import 'package:iPomodoro/common/utils/time_utils.dart';
import 'package:iPomodoro/model/countdown_model.dart';
import 'package:iPomodoro/ui/widget/cupertino_alert.dart';
import 'package:iPomodoro/ui/widget/time_dialog.dart';
import 'package:iPomodoro/generated/l10n.dart';

class CountdownEditPicker extends StatefulWidget {
  CountdownModel model;

  CountdownEditPicker({Key key, this.model}) : super(key: key);

  @override
  _CountdownEditPickerState createState() => _CountdownEditPickerState();
}

class _CountdownEditPickerState extends State<CountdownEditPicker> {

  TextEditingController _title_controller = TextEditingController();
  TextEditingController _time_controller = TextEditingController();
  TextEditingController _notes_controller = TextEditingController();
  FocusNode _notes_focusNode = FocusNode();
  bool _notes_textfild_focus = false;
  DateTime selected_time = DateTime.now();

  @override
  void initState() {
    super.initState();

    if (widget.model != null) {
      selected_time = widget.model.date;
      _title_controller.text = widget.model.title;
      _time_controller.text = TimeUtils.get_formatted_date(widget.model.date);
      _notes_controller.text = widget.model.notes;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: DeviceUtils.scale_width(context, 0.9, 0.8, 0.45),
          height: _notes_textfild_focus ? DeviceUtils.scale_height(context, 0.65, 0.55, 0.6) : DeviceUtils.scale_width(context, 1.06, 0.95, 0.55),
          color: AppColors.isDarkMode(context) ? Color(0xFF222222) : Colors.white,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Align(
                      child: Text(
                        S.of(context).tips_task,
                        style: TextStyle(
                          fontSize: DeviceUtils.get_size(context, 18, 20, 23),
                        ),
                      ),
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
              Divider(height: 1),
              Expanded(
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextField(
                          controller: _title_controller,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          maxLines: 1,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            // focusedBorder: OutlineInputBorder(
                            //   borderSide: BorderSide(
                            //       color: AppColors.TIMER_MAIN_COLOR),
                            // ),
                            // enabledBorder: OutlineInputBorder(
                            //     borderSide:
                            //         const BorderSide(color: Colors.grey)),
                            // hintText: 'Tell us about yourself',
                            // helperText: 'Keep it short, this is just a demo.',
                            labelText: S.of(context).tips_task_name,
                            prefixIcon: const Icon(
                              Icons.date_range_outlined,
                              size: 20,
                              color: AppColors.COUNTDOWN_MAIN_COLOR,
                            ),
                            suffixIcon: InkWell(
                              child: Icon(Icons.close, color: AppColors.isDarkMode(context) ? Colors.white38 : Colors.black26),
                              onTap: () {
                                _title_controller.clear();
                              },
                            ),
                          ),
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            // _pressed_time_textfield(context);
                          },
                          onTap: () {
                            if(_notes_focusNode.hasFocus) {
                              setState(() {
                                _notes_textfild_focus = false;
                              });
                            }
                          },
                        ),
                        SizedBox(
                            height: DeviceUtils.get_size(context, 15, 25, 30)),
                        InkWell(
                          onTap: () {
                            _pressed_time_textfield(context);
                          },
                          child: TextField(
                            enabled: false,
                            controller: _time_controller,
                            keyboardType: TextInputType.text,
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.isDarkMode(context) ? Colors.white38 : Colors.grey)),
                              labelText: S.of(context).tips_task_time,
                              labelStyle: TextStyle(
                                color: AppColors.isDarkMode(context) ? Colors.white60 : Colors.black54,
                              ),
                              prefixIcon: const Icon(
                                Icons.access_time_outlined,
                                size: 20,
                                color: AppColors.TIMER_MAIN_COLOR,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: DeviceUtils.get_size(context, 15, 25, 30)),
                        TextField(
                          controller: _notes_controller,
                          focusNode: _notes_focusNode,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            labelText: S.of(context).tips_task_tags,
                            prefixIcon: const Icon(
                              Icons.tag,
                              size: 20,
                              color: AppColors.PRIMARY_MAIN_COLOR,
                            ),
                            suffixIcon: InkWell(
                              child: Icon(Icons.close, color: AppColors.isDarkMode(context) ? Colors.white38 : Colors.black26),
                              onTap: () {
                                _notes_controller.clear();
                              },
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _notes_textfild_focus = true;
                            });
                          },
                          onEditingComplete: () {
                            setState(() {
                              _notes_textfild_focus = false;
                            });
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                        ),
                      ],
                    )),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 20),
                child: Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: AppColors.COUNTDOWN_MAIN_COLOR,
                      minimumSize: Size(
                          DeviceUtils.get_size(context, 100, 110, 120),
                          DeviceUtils.get_size(context, 36, 38, 50)),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      side: BorderSide(
                          width: 1.5, color: AppColors.COUNTDOWN_MAIN_COLOR),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                    ),
                    child: Text(
                      S.of(context).tips_save,
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.COUNTDOWN_MAIN_COLOR,
                      ),
                    ),
                    onPressed: () {
                      _pressed_confirm_button(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pressed_confirm_button(BuildContext context) {
    String title = _title_controller.text;
    String time = _time_controller.text;
    String notes = _notes_controller.text;
    if (title.isEmpty || time.isEmpty) {
      AlertView.show(context, S.of(context).tips_text, S.of(context).tips_task_empty);
      return;
    }

    CountdownModel model = widget.model;
    if (model != null) {
      model.title = title;
      model.date = selected_time;
      model.notes = notes;
    } else {
      model = CountdownModel(title, selected_time, notes);
    }
    model.modify_date = DateTime.now();
    //back
    Navigator.pop(context, model);
  }

  void _pressed_time_textfield(BuildContext context) {
    if(_notes_focusNode.hasFocus) {
      setState(() {
        _notes_textfild_focus = false;
      });
    }
    FocusScope.of(context).requestFocus(FocusNode());
    DatePicker().show(context, selected_time, CupertinoDatePickerMode.date, (dateTime) => null).then((date) {
      DatePicker().show(context, date, CupertinoDatePickerMode.time, (dateTime) => null).then((time) {
        String formattedDate = TimeUtils.get_formatted_date(time);
        _time_controller.text = formattedDate;
        setState(() {
          selected_time = time;
        });
      });
    });
  }


}
