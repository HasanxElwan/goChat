import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_chat/constants.dart';
import 'package:go_chat/helper/showSnakBar.dart';
import 'package:go_chat/widgets/customButton.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/customTextField.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({
    Key? key,
  }) : super(key: key);
  static String id = 'SignUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                          'Register',
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
                    text: 'Register',
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await registerUser();
                          showSnackBar(context, 'Success');
                          Navigator.pop(context);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showSnackBar(
                                context, 'The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            showSnackBar(context,
                                'The account already exists for that email.');
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
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Login',
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

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
