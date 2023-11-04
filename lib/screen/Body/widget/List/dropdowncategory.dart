import 'package:flutter/material.dart';
import 'package:project_event/screen/Body/widget/List/list.dart';

class CategoryDown extends StatefulWidget {
  final ValueChanged<String> onCategorySelected;

  const CategoryDown({
    super.key,
    required this.onCategorySelected,
  });

  @override
  State<CategoryDown> createState() => _CategoryDownState();
}

class _CategoryDownState extends State<CategoryDown> {
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = 'Accommodation';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
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
                      height: 50,
                      width: 50,
                    ),
                    const SizedBox(width: 8),
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
