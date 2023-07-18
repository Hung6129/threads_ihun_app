import 'package:flutter/material.dart';

PreferredSizeWidget appBarBuilder(String name) {
  return AppBar(
    elevation: 0,
    title: Text('Hello $name'),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.add_box_outlined),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.favorite_border_outlined),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.send),
      ),
    ],
  );
}
