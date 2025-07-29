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
        LabelWidget(item: item, isTemCoXuatXu: isTemCoXuatXu),
      ],
    );
  }
}
