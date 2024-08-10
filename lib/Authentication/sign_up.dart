import 'package:communication/Authentication/sign_in.dart';
import 'package:communication/Components/my_button.dart';
import 'package:communication/Components/my_textfield.dart';
import 'package:communication/Interface/interface.dart';
import 'package:communication/Utilities/Services/Authentication%20Services/auth_services.dart';
import 'package:communication/Utilities/controllers.dart';
import 'package:communication/Utilities/utils.dart';
import 'package:communication/consts.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //  controller instances
  final inputControllers = InputControllers();
  //  local loading variable for sign up loading animation for button
  bool loading = false;
  //  method to register user using firebase authentication
  void signUpUserMethod(BuildContext context) async {
    //  get the authentication services
    final authServices = AuthServices();
    //  method to sign up the user
    if (inputControllers.passwordController.text ==
        inputControllers.confirmPasswordController.text) {
      try {
        setState(() {
          loading = true;
        });
        authServices
            .signUpWithEmailAndPassword(inputControllers.emailController.text,
                inputControllers.passwordController.text)
            .then((value) {
          setState(() {
            loading = false;
          });
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const InterfacePage()));
          Utils().toastMessage(
              'Signed Up and Signed In as ${authServices.auth.currentUser!.email.toString()}');
        }).onError((error, stackTrace) {
          setState(() {
            loading = false;
          });
          Utils().toastMessage(error.toString());
        });
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(e.toString()),
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Passwords don\'t Match! Please try Again!'),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.message_rounded,
                color: Theme.of(context).colorScheme.primary,
                size: 55,
              ),
              const SizedBox(height: 10),
              Text(
                'Welcome Aboard! Let\'s Make Magic Happen!',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
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
                    MyTextfield(
                      labelText: 'Confirm Password',
                      obscure: true,
                      controller: inputControllers.confirmPasswordController,
                      suffixIcon: null,
                      validationRegExp: PASSWORD_VALIDATION_REGEX,
                      onSave: (value) {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              MyButton(
                buttontext: 'Sign Up'.toUpperCase(),
                onTap: () {},
                loading: loading,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already Have an Account? ',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignInPage()));
                    },
                    child: Text(
                      'Sign In'.toUpperCase(),
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
