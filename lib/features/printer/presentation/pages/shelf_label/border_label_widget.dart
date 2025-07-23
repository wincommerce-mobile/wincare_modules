import 'package:flutter/material.dart';

import '../../../data/models/shelf_label_item.dart';
import 'label_widget.dart';

class BorderLabelWidget extends StatelessWidget {
  const BorderLabelWidget({super.key, required this.item, required this.isTemCoXuatXu});

  final ShelfLabelItem item;
  final bool isTemCoXuatXu;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
        LabelWidget(item: item, isTemCoXuatXu: isTemCoXuatXu),
      ],
    );
  }
}
