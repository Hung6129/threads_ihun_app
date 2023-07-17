import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../main_menu/main_menu_view.dart';
import 'widgets/authenticate_widgets.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 100.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              headerTitle('Welcome to', 'Threads iHun'),
              CusTextFeild(
                onChange: (value) {},
                controller: _emailController,
                lblText: 'Enter your email',
                iconData: Icons.email,
              ),
              CusTextFeild(
                onChange: (value) => {},
                controller: _passwordController,
                lblText: 'Enter your password',
                iconData: Icons.lock,
                txtfType: 'password',
              ),
              actionBtn(() {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainMenuView(),
                    ),
                    (route) => false);
              }, 'signIn'),
              SizedBox(
                height: 10.h,
              ),
              ForgotPassword(
                ontap: () {},
              ),
              otherSignIn(),
              SignInWithThirdParty(ggSignIn: () {}, fbSignIn: () {}),
              const CusDivider(),
              const CusAuthNav(authNavType: 'signIn', navTo: '/sign_up')
            ],
          ),
        ),
      ),
    );
  }
}
