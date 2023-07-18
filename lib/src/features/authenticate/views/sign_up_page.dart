import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/widgets/flutter_toast.dart';
import '../controllers/auth_controller.dart';
import 'widgets/authenticate_widgets.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reTypePasswordController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _reTypePasswordController.dispose();
    _userNameController.dispose();
  }

  void onSignUp() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final reTypePassword = _reTypePasswordController.text.trim();
    final userName = _userNameController.text.trim();
    if (email.isNotEmpty &&
        password.isNotEmpty &&
        reTypePassword.isNotEmpty &&
        userName.isNotEmpty) {
      if (password == reTypePassword) {
        ref.read(authControllerProvider.notifier).signUp(
              userName: userName,
              email: email,
              password: password,
              context: context,
            );
      } else {
        toastInfor(text: 'Password and retype password not match');
      }
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
                    headerTitle('Sign up to enter', 'Threads iHun'),
                    CusTextFeild(
                        onChange: (value) {},
                        controller: _userNameController,
                        lblText: 'Enter your username',
                        iconData: Icons.person_rounded),
                    CusTextFeild(
                        onChange: (value) {},
                        controller: _emailController,
                        lblText: 'Enter your email',
                        iconData: Icons.email_rounded),
                    CusTextFeild(
                        onChange: (value) {},
                        controller: _passwordController,
                        lblText: 'Enter your passwod',
                        txtfType: 'password',
                        iconData: Icons.password_rounded),
                    CusTextFeild(
                        onChange: (value) {},
                        controller: _reTypePasswordController,
                        lblText: 'Retype your passwod',
                        txtfType: 'password',
                        iconData: Icons.password_rounded),
                    SizedBox(
                      height: 10.h,
                    ),
                    actionBtn(onSignUp, ''),
                    ForgotPassword(
                      ontap: () {},
                    ),
                    const CusDivider(),
                    const CusAuthNav(authNavType: 'signUp', navTo: '/')
                  ],
                ),
              ),
            ),
    );
  }
}
