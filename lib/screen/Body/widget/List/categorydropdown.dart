import 'package:flutter/material.dart';
import 'package:project_event/screen/Body/widget/List/list.dart';
import 'package:sizer/sizer.dart';

class CategoryDown extends StatefulWidget {
  final ValueChanged<String> onCategorySelected;
  final String? defaultdata;

  const CategoryDown({
    super.key,
    required this.onCategorySelected,
    this.defaultdata,
  });

  @override
  State<CategoryDown> createState() => _CategoryDownState();
}

class _CategoryDownState extends State<CategoryDown> {
  String? selectedCategory;

  @override
  void initState() {
    super.initState();

    selectedCategory = widget.defaultdata ?? 'Accommodation';

    if (selectedCategory!.isEmpty) {
      selectedCategory = 'Accommodation';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(1.h, 0.2.h, 1.h, 0.2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Category'),
          DropdownButton<String>(
            isExpanded: true,
            value: selectedCategory,
            items: category.map((categoryItem) {
              return DropdownMenuItem<String>(
                value: categoryItem['text'],
                child: Row(
                  children: [
                    Image(
                      image: categoryItem['image'],
                      height: 8.h,
                      width: 8.h,
                    ),
                    SizedBox(width: 0.8.h),
                    Text(
                      categoryItem['text'],
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCategory = value;
                // Call the callback function to send the selected value
                widget.onCategorySelected(value!);
              });
            },
          ),
        ],
      ),
    );
  }
}
