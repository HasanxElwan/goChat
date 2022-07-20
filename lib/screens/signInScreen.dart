import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_chat/constants.dart';
import 'package:go_chat/helper/showSnakBar.dart';
import 'package:go_chat/screens/chatScreen.dart';
import 'package:go_chat/screens/signUpScreen.dart';
import 'package:go_chat/widgets/customButton.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/customTextField.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({
    Key? key,
  }) : super(key: key);
  static String id = 'SignInScreen';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 75),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset(
                    kLogo,
                    width: 150,
                    height: 150,
                  ),
                  const Text(
                    'Go Chat',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Arimaa',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'bring great chat for you',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: const [
                        Text(
                          'Login',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'Email Address',
                    prefixIcon: const Icon(Icons.email),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    onChanged: (data) {
                      email = data;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    onChanged: (data) {
                      password = data;
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomButton(
                    text: 'Login',
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await loginUser();
                          Navigator.pushNamed(context, ChatScreen.id,
                              arguments: email);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showSnackBar(
                                context, 'No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            showSnackBar(context,
                                'Wrong password provided for that user.');
                          }
                        } catch (e) {
                          print(e);
                        }
                        isLoading = false;
                        setState(() {});
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('already have an account ?   '),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SignUpScreen.id);
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(color: kPrimaryColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
