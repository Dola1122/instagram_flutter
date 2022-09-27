import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_flutter/utils/colors.dart';

import '../widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Container(),),
            SvgPicture.asset(
              "assets/ic_instagram.svg",
              height: 64,
              color: primaryColor,
            ),
            const SizedBox(height: 64),
            TextFieldInput(
              controller: _emailController,
              hintText: "Enter your email",
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),
            TextFieldInput(
              controller: _emailController,
              hintText: "Enter your password",
              textInputType: TextInputType.visiblePassword,
              isPassword: true,
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              child: MaterialButton(
                onPressed: () {},
                color: Colors.blue,
                child: const Text("Log in"),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            Expanded(child: Container(),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text("Don't have an account? "),
                ),
                GestureDetector(
                  onTap: (){},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Sing up"),
                  ),
                )
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    ));
  }
}
