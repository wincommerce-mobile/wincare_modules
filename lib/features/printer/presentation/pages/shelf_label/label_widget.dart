import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wincare_modules/app/app_extensions.dart';

import '../../../../../core/theme.dart';
import '../../../data/models/shelf_label_item.dart';

class LabelWidget extends StatelessWidget {
  const LabelWidget({super.key, required this.item});

  final ShelfLabelItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Column(
              children: [
                Container(
                  width: 384,
                  height: 300,
                  color: Colors.white,
                  //padding: EdgeInsets.only(top: 12),
                  //height: 240,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Product name
                      Text(
                        item.name,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                          fontSize: LabelSize.pt10,
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
                                  size: 85,
                                  padding: EdgeInsets.all(2),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.qrCode,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ],
                            ),

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
                                                  maxFontSize: 107,
                                                  minFontSize: 14,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    fontSize: 107,
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 35,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  item.decimal,
                                                  style: TextStyle(
                                                    fontSize: LabelSize.pt12,
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
                                    'Ngày áp dụng: ${item.fromDate.formatDateNoYear()} - ${item.toDate.formatDate()}',
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
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 35,
              right: 10,
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
