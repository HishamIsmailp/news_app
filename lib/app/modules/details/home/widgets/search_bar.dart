import 'package:flutter/material.dart';

class NewsSearchBar extends StatelessWidget {
  final Function(String) onSearch;

  const NewsSearchBar({Key? key, required this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search news...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        onChanged: (value) => onSearch(value),
      ),
    );
  }
}