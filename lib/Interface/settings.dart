import 'package:communication/Interface/blocked_users_page.dart';
import 'package:communication/Provider/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: const Text(
          'SETTINGS',
          style: TextStyle(
            letterSpacing: 4,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height * .01),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //  dark mode
                  const Text(
                    'Blocked Users',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  // button that navigates to blocked users page
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const BlockedUsersPage()));
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).colorScheme.secondary,
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
