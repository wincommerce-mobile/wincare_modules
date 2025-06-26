import 'package:flutter/material.dart';

import '../../../data/models/shelf_label_item.dart';
import 'label_widget.dart';

class NoBorderLabelWidget extends StatelessWidget {
  const NoBorderLabelWidget({super.key, required this.item});

  final ShelfLabelItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 384,
            child: LabelWidget(item: item),
          ),
        ),
        Divider(height: 75, color: Colors.grey),
      ],
    );
  }
}
