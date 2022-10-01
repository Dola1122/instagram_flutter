import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';
import 'package:instagram_flutter/utils/colors.dart';
import '../utils/utils.dart';
import '../widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );
    setState(() {
      _isLoading = false;
    });
    if (res != "success") {
      showSnackBar(res, context);
    }
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
            Flexible(
              flex: 2,
              child: Container(),
            ),
            SvgPicture.asset(
              "assets/ic_instagram.svg",
              height: 64,
              color: primaryColor,
            ),
            const SizedBox(height: 32),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                _image != null
                    ? CircleAvatar(
                        backgroundImage: MemoryImage(_image!),
                        radius: 64,
                      )
                    : const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://media.istockphoto.com/vectors/default-profile-picture-avatar-photo-placeholder-vector-illustration-vector-id1223671392?k=20&m=1223671392&s=612x612&w=0&h=lGpj2vWAI3WUT1JeJWm1PRoHT3V15_1pdcTn2szdwQ0="),
                        radius: 64,
                      ),
                Positioned(
                  bottom: -5,
                  right: -5,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: Icon(Icons.add_a_photo),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            TextFieldInput(
              controller: _usernameController,
              hintText: "Enter your username",
              textInputType: TextInputType.text,
            ),
            const SizedBox(height: 24),
            TextFieldInput(
              controller: _emailController,
              hintText: "Enter your email",
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),
            TextFieldInput(
              controller: _passwordController,
              hintText: "Enter your password",
              textInputType: TextInputType.visiblePassword,
              isPassword: true,
            ),
            const SizedBox(height: 24),
            TextFieldInput(
              controller: _bioController,
              hintText: "Enter your bio",
              textInputType: TextInputType.text,
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              child: MaterialButton(
                onPressed: signUpUser,
                color: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: _isLoading? const CircularProgressIndicator(color: primaryColor,) : const Text("Sign up"),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text("Don't have an account? "),
                ),
                GestureDetector(
                  onTap: () {},
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
