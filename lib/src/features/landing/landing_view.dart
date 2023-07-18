import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/constants/palettes.dart';
import '../../config/constants/text_styles.dart';
import '../authenticate/views/sign_in_page.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => const SignInPage(),
          ),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Spacer(),
          Center(
            child: Text.rich(
              TextSpan(
                text: 'Welcome to\n',
                style: TextStyles.customStyle.smallText,
                children: [
                  TextSpan(
                    text: 'Threads',
                    style: TextStyles.customStyle.bold
                        .setTextSize(50.sp)
                        .setColor(Palettes.p2),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(
              bottom: 50.h,
            ),
            child: Text.rich(
              TextSpan(
                text: 'Powered by ',
                style: TextStyles.customStyle.smallText,
                children: [
                  TextSpan(
                    text: 'iHun',
                    style: TextStyles.customStyle.smallText.bold
                        .setColor(Palettes.p2),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
