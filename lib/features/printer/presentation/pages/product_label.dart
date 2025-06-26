import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProductLabel extends StatelessWidget {
  const ProductLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 150,
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          // QR Code & Barcode
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              QrImageView(
                data: '8935001712435',
                size: 50,
              ),
              const SizedBox(height: 4),
              const Text('8935001712435', style: TextStyle(fontSize: 10)),
            ],
          ),
          const SizedBox(width: 8),

          // Product Info & Prices
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ALPENLIEBE Kẹo Mềm H.Dâu 2Chew',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                const Text(
                  '73,5g',
                  style: TextStyle(fontSize: 11),
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Big "13"
                    const Text(
                      '13',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // ".500đ"
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          '15.900đ',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          '.500đ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ngày áp dụng: 19/06 - 02/07/2025',
                      style: TextStyle(fontSize: 10),
                    ),
                    Text('ĐVT: G1', style: TextStyle(fontSize: 10)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
