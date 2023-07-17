import 'package:flutter/material.dart';
import 'package:threads_ihun_app/config/constants/palettes.dart';

PreferredSizeWidget appBarBuilder() {
  return AppBar(
    elevation: 0,
    title: const Text('Instagram'),
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
