import 'package:communication/Authentication/sign_in.dart';
import 'package:communication/Components/button.dart';
import 'package:communication/Utilities/Services/Authentication%20Services/auth_services.dart';
import 'package:communication/Utilities/utils.dart';
import 'package:flutter/material.dart';

class InterfacePage extends StatefulWidget {
  const InterfacePage({super.key});

  @override
  State<InterfacePage> createState() => _InterfacePageState();
}

class _InterfacePageState extends State<InterfacePage> {
  //  method to sign the user out
  void logOut() async {
    //  fetching the authentication services
    final authServices = AuthServices();
    //  signing the user out
    await authServices.signOutMethod().then((value) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const SignInPage()));
      Utils().toastMessage('See You Soon Again! Good Bye!');
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Interface Page'),
      ),
      endDrawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              Icon(
                Icons.message_sharp,
                size: 45,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              FlatButton(
                iconB: Icons.info_outline,
                text: 'About Me',
                onPressed: () {},
              ),
              FlatButton(
                iconB: Icons.logout_sharp,
                text: 'Good Bye!',
                onPressed: () {
                  logOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
