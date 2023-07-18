import 'package:flutter/material.dart';

import '../../post/create_post_view.dart';

PreferredSizeWidget appBarBuilder(String name, BuildContext context) {
  return AppBar(
    elevation: 0,
    title: Text(name),
    actions: [
      IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreatePostView(),
              fullscreenDialog: true,
            ),
          );
        },
        icon: const Icon(Icons.add_box_outlined),
      ),
    ],
  );
}
