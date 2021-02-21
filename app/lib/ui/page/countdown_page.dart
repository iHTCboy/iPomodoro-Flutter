import 'package:flutter/material.dart';
import 'package:iPomodoro/common/constant/app_colors.dart';
import 'package:iPomodoro/common/utils/config_storage.dart';
import 'package:iPomodoro/common/utils/device_utils.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iPomodoro/model/countdown_model.dart';
import 'package:iPomodoro/ui/widget/countdown_edit_picker.dart';
import 'package:iPomodoro/ui/widget/cupertino_alert.dart';

enum SliableType {
  edit,
  delete,
}


class CountdownPagee extends StatefulWidget {
  @override
  _CountdownPageeState createState() => _CountdownPageeState();
}

class _CountdownPageeState extends State<CountdownPagee> {
  QueryType currentQueryType = QueryType.idDesc;
  List<CountdownModel> list_tasks = [];

  @override
  void initState() {
    super.initState();

    data_init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('定时任务'),
        brightness: Brightness.dark,
        backgroundColor: AppColors.COUNTDOWN_MAIN_COLOR,
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed('/countdown_settings')
                  .then((value) {
                    _back_setting_page();
              });
            },
            icon: Icon(Icons.settings),
            label: Text(''),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
          )
        ],
      ),
      body: list_tasks.isEmpty ? get_void_widget() : RefreshIndicator(
        color: AppColors.COUNTDOWN_MAIN_COLOR,
        onRefresh: () async {
          _refresh_header();
        },
        child: Container(
          // color: AppColors.COUNTDOWN_SUB_COLOR,
          child: ListView.builder(
              padding: EdgeInsets.only(bottom: 80),
              itemCount: list_tasks.length,
              itemBuilder: (ctx, idx) {
                return get_row(ctx, idx);
              }
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pressed_add_task,
        tooltip: '添加新任务',
        child: Icon(Icons.add, size: 35),
        backgroundColor: AppColors.COUNTDOWN_MAIN_COLOR,
      ),
    );
  }

  Widget get_void_widget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notes, size: DeviceUtils.get_size(context, 50, 55, 65), color: AppColors.COUNTDOWN_MAIN_COLOR,),
          Text('无任务'),
        ],
      )
    );
  }

  void data_init() {
    CountdownModel.init_database();
    reload_data(currentQueryType);
  }

  void reload_data(QueryType queryType) {
    CountdownModel.query_all_data(queryType).then((List value) {
      List<CountdownModel> result = value.map<CountdownModel>((json) => CountdownModel.fromJson(json)).toList();
      setState(() {
        list_tasks = result;
      });
    });
  }

  void _refresh_header() {
    reload_data(currentQueryType);
  }

  void _back_setting_page() {
    AppStorage.getInt(AppStorage.K_STRING_CUNTDOWN_ORDER_INDEX).then((value) {
      int order_index = value ?? 0;
      currentQueryType = QueryType.shard.getTypes[order_index];
      reload_data(currentQueryType);
    });
  }

  void _pressed_add_task() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => CountdownEditPicker()).then((value) {
      if (value != null) {
        _add_task(value);
      }
    });
  }

  void _add_task(CountdownModel model) {
    // database add
    CountdownModel.insert_data(model).then((id) {
      model.itemId = id;
      setState(() {
        list_tasks.insert(0, model);
      });
    });
  }

  void _showSnackBar(SliableType actionType, int index) {
    if (actionType == SliableType.edit) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => CountdownEditPicker(model: list_tasks[index])).then((value) {
        if (value != null) {
          setState(() {
            list_tasks[index] = value;
          });
          // database update
          CountdownModel.update_data(value);
        }
      });
    }

    if (actionType == SliableType.delete) {
      var model = list_tasks[index];
      AlertView.show(context, '提示', '确认要删除“${model.title}”这个任务吗？',
          cancelText: '否', confirmText: '是').then((value) {
        if (value) {
          setState(() {
            list_tasks.removeAt(index);
          });
          // database delete
          CountdownModel.delete_data(model);
        }
      });
    }
  }

  Widget get_row(BuildContext context, int index) {
    final rightActionMenu = [
      IconSlideAction(
        caption: '修改',
        color: AppColors.TIMER_MAIN_COLOR,
        icon: Icons.edit_outlined,
        onTap: () => _showSnackBar(SliableType.edit, index),
      ),
      IconSlideAction(
        caption: '删除',
        color: AppColors.PRIMARY_MAIN_COLOR,
        icon: Icons.delete_outlined,
        onTap: () => _showSnackBar(SliableType.delete, index),
      )
    ];

    CountdownModel model = list_tasks[index];

    return Slidable(
      secondaryActions: rightActionMenu,
      actionPane: SlidableStrechActionPane(),
      child: InkWell(
        // onTap: () {
        //
        // },
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
          decoration: BoxDecoration(
            color: AppColors.isDarkMode(context) ? Colors.black12 : Colors.white,
            border: Border(bottom: BorderSide(color: AppColors.isDarkMode(context) ? Colors.white10 : Colors.black12, width: 1)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: DeviceUtils.get_size(context, 21, 23, 25),
                    color: AppColors.isDarkMode(context) ? Colors.white70 : Colors.black87),
              ),
              SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_outlined,
                            color: AppColors.TIMER_MAIN_COLOR,
                            size: 15,
                          ),
                          SizedBox(width: 5),
                          Text(
                            model.date_string(),
                            style: TextStyle(color: AppColors.isDarkMode(context) ? Colors.white54 : Colors.black54),
                          ),
                        ],
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.local_offer_outlined,
                            color: AppColors.PRIMARY_MAIN_COLOR,
                            size: 15,
                          ),
                          SizedBox(width: 5),
                          Text(
                            model.notes.isEmpty ? '无' : model.notes,
                            style: TextStyle(color: AppColors.isDarkMode(context) ? Colors.white54 : Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${model.countdown_day()}',
                        style: TextStyle(
                            fontSize: DeviceUtils.get_size(context, 25, 30, 35),
                            color: AppColors.COUNTDOWN_MAIN_COLOR),
                      ),
                      Text(
                        '天',
                        style: TextStyle(color: AppColors.isDarkMode(context) ? Colors.white54 : Colors.black45),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
