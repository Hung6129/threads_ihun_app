import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../post/widgets/post_widgets.dart';
import 'widgets/home_view_widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBuilder('ThreadsiHun', context),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const PostCardView();
        },
      ),
    );
  }
}
