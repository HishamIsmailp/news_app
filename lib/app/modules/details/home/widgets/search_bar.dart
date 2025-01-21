import 'package:flutter/material.dart';

class NewsSearchBar extends StatelessWidget {
  final Function(String) onSearch;

  const NewsSearchBar({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search news...',
          prefixIcon: const Icon(Icons.search),
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