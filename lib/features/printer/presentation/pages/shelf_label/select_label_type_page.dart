import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wincare_modules/app/app_pages.dart';

import '../../../data/models/label_type.dart';

class SelectLabelTypePage extends StatefulWidget {
  const SelectLabelTypePage({super.key});

  @override
  State<SelectLabelTypePage> createState() => _SelectLabelTypePageState();
}

class _SelectLabelTypePageState extends State<SelectLabelTypePage> {
  LabelType? selectedLabelType;

  final List<LabelType> labelTypes = [
    LabelType(
      id: '1',
      name: 'Tem kệ có viền',
      imagePath: 'assets/images/label_border.png',
    ),
    LabelType(
      id: '2',
      name: 'Tem kệ không viền',
      imagePath: 'assets/images/label_no_border.png',
    ),
  ];

  void _moveToPrintShelf() {
    if (selectedLabelType != null) {
      Get.toNamed(AppRoutes.label, arguments: selectedLabelType);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CHỌN LOẠI TEM KỆ',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
        backgroundColor: Color(0xFFC6142C),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GridView.builder(
          padding: EdgeInsets.all(16),
          itemCount: labelTypes.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final labelType = labelTypes[index];
            final isSelected = labelType.id == selectedLabelType?.id;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedLabelType = labelType;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? Colors.red : Colors.transparent,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Card(
                  elevation: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(labelType.imagePath, height: 100),
                      SizedBox(height: 8),
                      Text(labelType.name),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: selectedLabelType == null ? null : _moveToPrintShelf,
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
            backgroundColor: selectedLabelType != null
                ? Color(0xFFC6142C)
                : Colors.grey,
          ),
          child: Text(
            'IN TEM KỆ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Roboto',
              color: selectedLabelType != null ? Colors.white : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
