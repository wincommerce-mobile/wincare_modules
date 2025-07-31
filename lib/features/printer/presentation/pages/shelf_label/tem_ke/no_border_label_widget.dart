import 'package:flutter/material.dart';

import '../../../../data/models/shelf_label_item.dart';
import 'label_widget.dart';

class NoBorderLabelWidget extends StatelessWidget {
  const NoBorderLabelWidget({
    super.key,
    required this.item,
    required this.isTemCoXuatXu,
  });

  final ShelfLabelItem item;
  final bool isTemCoXuatXu;

  @override
  Widget build(BuildContext context) {
    return LabelWidget(item: item, isTemCoXuatXu: isTemCoXuatXu);
  }
}
