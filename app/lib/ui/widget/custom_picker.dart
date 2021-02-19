import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPicker {
  Future<int> show(BuildContext context, List<String> contentList, int selectItem,
      onSelectedItemChanged(int position),
      {bool looping = true, String title=''}) async {

    int positionItem = await showModalBottomSheet<int>(
        enableDrag: false,
        isDismissible: false,
        context: context,
        builder: (context) {
          int oldPosition = selectItem;
          int tempPosition = oldPosition;
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
                          Navigator.of(context).pop(oldPosition);
                        },
                      ),
                      Text(title, style: TextStyle(fontSize: 18, color: Colors.black87)),
                      CupertinoButton(
                        child: Text('确认'),
                        onPressed: () {
                          Navigator.of(context).pop(tempPosition);
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
                    child: CupertinoPicker(
                      itemExtent: 35,
                      magnification: 1.1,
                      looping: looping,
                      scrollController: FixedExtentScrollController(initialItem: selectItem),
                      onSelectedItemChanged: (position) {
                        tempPosition = position;
                        onSelectedItemChanged(position);
                      },
                      children: contentList.map((value) {
                        return Text(value);
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          );
        });

    return positionItem;
  }
}
