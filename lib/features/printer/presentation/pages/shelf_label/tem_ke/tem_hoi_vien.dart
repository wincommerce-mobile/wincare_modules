import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../../core/theme.dart';
import '../../../../data/models/shelf_label_item.dart';

class TemHoiVien extends StatelessWidget {
  const TemHoiVien({
    super.key,
    required this.item,
    required this.isTemCoXuatXu,
  });

  final ShelfLabelItem item;
  final bool isTemCoXuatXu;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              width: 384,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60),

                  /// Product name
                  ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 40),
                    child: SizedBox(
                      width: 384,
                      child: Text(
                        item.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                          fontSize: LabelSize.pt8,
                        ),
                      ),
                    ),
                  ),

                  Column(
                    children: [
                      Stack(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: 100,
                                  maxWidth: 210,
                                ),
                                child: AutoSizeText(
                                  item.specMajor,
                                  maxFontSize: LabelSize.pt47,
                                  minFontSize: 14,
                                  maxLines: 1,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: LabelSize.pt47,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 4),

                              /// virtual product qr
                              const SizedBox(width: 90),
                            ],
                          ),
                          Positioned(
                            top: item.specMajor.length > 4 ? -6 : 0,
                            right: 0,
                            child: Container(
                              alignment: Alignment.topCenter,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 2),
                                  Text(
                                    item.specDecimal,
                                    style: TextStyle(
                                      fontSize: LabelSize.pt15,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  SizedBox(
                                    width: 80,
                                    child: Text(
                                      'ĐVT: ${item.unitOfMeasure}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: LabelSize.pt6,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ),

                                  if (isTemCoXuatXu) ...[
                                    const SizedBox(height: 12),
                                    SizedBox(
                                      width: 80,
                                      child: Text(
                                        'Xuất xứ: ${item.countryOri}',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: LabelSize.pt5,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    'Giá thường',
                    style: TextStyle(
                      fontSize: LabelSize.pt5,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 2),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AutoSizeText(
                            item.originMajor,
                            maxFontSize: LabelSize.pt17,
                            minFontSize: 14,
                            maxLines: 1,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: LabelSize.pt17,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            alignment: Alignment.topCenter,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.originDecimal,
                                  style: TextStyle(
                                    fontSize: LabelSize.pt5,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'ĐVT: ${item.unitOfMeasure}',
                                  style: TextStyle(
                                    fontSize: LabelSize.pt5,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 25),
                ],
              ),
            ),
            Positioned(
              bottom: 25,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
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
                      fontSize: LabelSize.pt6,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Ngày áp dụng: ${item.getSpecApplyDate()}',
                    style: TextStyle(
                      fontSize: LabelSize.pt5,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        //Divider(height: 70, color: Colors.white, thickness: 0),
      ],
    );
  }
}
