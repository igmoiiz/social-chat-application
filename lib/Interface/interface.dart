import 'package:communication/Authentication/sign_in.dart';
import 'package:communication/Components/button.dart';
import 'package:communication/Components/user_tile.dart';
import 'package:communication/Interface/chat_page.dart';
import 'package:communication/Interface/settings.dart';
import 'package:communication/Utilities/Services/Authentication%20Services/auth_services.dart';
import 'package:communication/Utilities/Services/Chat%20Services/chat_services.dart';
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

  //  chat and authentication services
  final AuthServices authServices = AuthServices();
  final chatServices = ChatServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'HOME',
          style: TextStyle(
            letterSpacing: 4,
          ),
        ),
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
                iconB: Icons.settings,
                text: 'Settings',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SettingsPage()));
                },
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
      //  body
      body: _buildUserList(),
    );
  }

  // for building a stream of users
  Widget _buildUserList() {
    return StreamBuilder(
      stream: chatServices.getUserStream(),
      builder: (context, snapshot) {
        //  errors
        if (snapshot.hasError) {
          return Text('Exception Caught! ${snapshot.error.toString()}');
        }
        //  loading
        else if (!snapshot.hasData) {
          return const Column(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator()),
              Align(
                  alignment: Alignment.center,
                  child: Text('Loading Please Wait!')),
            ],
          );
        }
        //  return list view
        else {
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        }
      },
    );
  }

  //for building individual list tiles
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    //  display all users except current user
    if (userData['email'] != authServices.getCurrentUser()!.email) {
      return UserTile(
        text: userData['email'],
        onTap: () {
          //  navigate to chat screen
          //tap on the user  ->  go to chat page
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData['email'],
                receiverId: userData['uid'],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
