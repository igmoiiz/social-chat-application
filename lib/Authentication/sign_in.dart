import 'package:communication/Authentication/sign_up.dart';
import 'package:communication/Components/my_button.dart';
import 'package:communication/Components/my_textfield.dart';
import 'package:communication/Interface/interface.dart';
import 'package:communication/Utilities/Services/Authentication%20Services/auth_services.dart';
import 'package:communication/Utilities/controllers.dart';
import 'package:communication/Utilities/utils.dart';
import 'package:communication/consts.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  //  instance to get all the input controllers
  final inputControllers = InputControllers();
  //  local boolean variable for sign in button circular progress indicator animation
  bool loading = false;
  //  method for signing in the user using firebase authentication
  void signIn(BuildContext context) {
    //  auth services
    final authServices = AuthServices();
    //  try to log the user in
    try {
      setState(() {
        loading = true;
      });
      authServices
          .signInWithEmailAndPassword(inputControllers.emailController.text,
              inputControllers.passwordController.text)
          .then((value) {
        setState(() {
          loading = false;
        });
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const InterfacePage()));
        Utils().toastMessage('Signed In Successfully!');
      }).onError((error, stackTrace) {
        setState(() {
          loading = false;
        });
        Utils().toastMessage(error.toString());
      });
    }
    //  catch any errors or exceptions
    catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(e.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .21),
              Icon(
                Icons.message_rounded,
                color: Theme.of(context).colorScheme.primary,
                size: 55,
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Welcome Back! You\'ve Been Missed!',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: inputControllers.formKey,
                child: Column(
                  children: [
                    MyTextfield(
                      labelText: 'Email',
                      obscure: false,
                      controller: inputControllers.emailController,
                      suffixIcon: null,
                      validationRegExp: EMAIL_VALIDATION_REGEX,
                      onSave: (value) {},
                    ),
                    MyTextfield(
                      labelText: 'Password',
                      obscure: true,
                      controller: inputControllers.passwordController,
                      suffixIcon: null,
                      validationRegExp: PASSWORD_VALIDATION_REGEX,
                      onSave: (value) {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              MyButton(
                buttontext: 'Sign In'.toUpperCase(),
                onTap: () {
                  signIn(context);
                },
                loading: loading,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t Have an Account? ',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignUpPage()));
                    },
                    child: Text(
                      'Sign Up'.toUpperCase(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
