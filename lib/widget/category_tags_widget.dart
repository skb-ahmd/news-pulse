import 'package:flutter/material.dart';

class CategoryTagsWidget extends StatefulWidget {
  final List<String> categories;
  final ValueChanged<String> onCategorySelected;

  CategoryTagsWidget({
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  _CategoryTagsWidgetState createState() => _CategoryTagsWidgetState();
}

class _CategoryTagsWidgetState extends State<CategoryTagsWidget> {
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.categories.first;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: widget.categories.map((category) {
        return _buildCategoryTag(category);
      }).toList(),
    );
  }

  Widget _buildCategoryTag(String category) {
    bool isSelected = category == selectedCategory;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
        widget.onCategorySelected(category);
      },
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey[200],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
