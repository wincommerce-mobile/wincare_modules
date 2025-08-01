import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../../core/theme.dart';
import '../../../../data/models/shelf_label_item.dart';

class LabelWidget extends StatelessWidget {
  const LabelWidget({super.key, required this.item, required this.isTemCoXuatXu});

  final ShelfLabelItem item;
  final bool isTemCoXuatXu;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  width: 384,
                  //height: 300,
                  //color: Colors.red,
                  //padding: EdgeInsets.only(top: 12),
                  //height: 240,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Product name
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 56,
                        ),
                        child: SizedBox(
                          width: 384,
                          child: Text(
                            item.name,
                            maxLines: 2,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              height: 1,
                              fontSize: LabelSize.pt10,
                            ),
                          ),
                        ),
                      ),

                      /// QR & big text
                      SizedBox(
                        height: 185,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            /// QR Code
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                QrImageView(
                                  data: item.qrCode,
                                  size: 90,
                                  gapless: false,
                                  padding: EdgeInsets.all(2),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.qrCode,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),

                            /// Row spacer

                            /// Big text & price
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        Container(
                                          //width: 250,
                                          //height: 110,
                                          alignment: Alignment.topRight,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Expanded(
                                                child: AutoSizeText(
                                                  item.major,
                                                  maxFontSize: 117,
                                                  minFontSize: 14,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    fontSize: 117,
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 55,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  item.decimal,
                                                  style: TextStyle(
                                                    fontSize: 28,
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isTemCoXuatXu) ...[
                                    Text(
                                      'Xuất xứ: ${item.countryOri}',
                                      style: TextStyle(
                                        fontSize: LabelSize.pt6,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                  ],
                                  Text(
                                    'ĐVT: ${item.unitOfMeasure}',
                                    style: TextStyle(
                                      fontSize: LabelSize.pt8,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Ngày áp dụng: ${item.getApplyDate()}',
                                    style: TextStyle(
                                      fontSize: LabelSize.pt6,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 46,
              right: 0,
              child: Text(
                item.discountedPriceFormatted(),
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  fontSize: LabelSize.pt10,
                ),
              ),
            ),
          ],
        ),
        //Divider(height: 70, color: Colors.white, thickness: 0),
      ],
    );
  }
}
