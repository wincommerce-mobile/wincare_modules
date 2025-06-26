import 'package:flutter/material.dart';

import '../../../data/models/shelf_label_item.dart';
import 'label_widget.dart';

class BorderLabelWidget extends StatelessWidget {
  const BorderLabelWidget({super.key, required this.item});

  final ShelfLabelItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 384,
            //padding: EdgeInsets.only(bottom: 4),
            child: Column(
              children: [
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.only(bottom: 8.0, top: 6.0),
                  height: 75,
                  child: Center(
                    child: Text(
                      item.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontSize: 42,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                LabelWidget(item: item),
              ],
            ),
          ),
        ),
        Divider(height: 75, color: Colors.white, thickness: 0),
      ],
    );
  }
}
