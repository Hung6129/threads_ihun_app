import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:threads_ihun_app/config/widgets/flutter_toast.dart';
import 'package:threads_ihun_app/features/authenticate/controllers/auth_controller.dart';

import 'widgets/authenticate_widgets.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void onSignIn() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    if (email.isNotEmpty && password.isNotEmpty) {
      ref.read(authControllerProvider.notifier).signIn(
            email: email,
            password: password,
            context: context,
          );
    } else {
      toastInfor(text: 'Please fill all fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 18.w, vertical: 100.h),
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
                    actionBtn(onSignIn, 'signIn'),
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
