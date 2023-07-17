import 'package:flutter/material.dart';
import 'package:threads_ihun_app/config/constants/palettes.dart';

import 'widgets/home_view_widgets.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: appBarBuilder(),
      body: const Center(
        child: Text(
          'Home View',
        ),
      ),
    );
  }
}
