import 'package:communication/Components/user_tile.dart';
import 'package:communication/Utilities/Services/Authentication%20Services/auth_services.dart';
import 'package:communication/Utilities/Services/Chat%20Services/chat_services.dart';
import 'package:flutter/material.dart';

class BlockedUsersPage extends StatefulWidget {
  const BlockedUsersPage({super.key});

  @override
  State<BlockedUsersPage> createState() => _BlockedUsersPageState();
}

class _BlockedUsersPageState extends State<BlockedUsersPage> {
  //  instances of chat and authentication services
  final ChatServices chatServices = ChatServices();
  final AuthServices authService = AuthServices();

  //   unblock box
  void showUnblockBox(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'Un-Block Message',
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        content: Text(
          'Are you sure you want to Un-Block this User?',
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        actions: [
          //  cancel Button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          //  unblock button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              chatServices.unBlockUser(userId);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('User Un-Blocked Successfully!')));
            },
            child: Text(
              'Unblock',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //  variable that gets the userId
    String userId = authService.getCurrentUser()!.uid;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Text('Blocked Users'.toUpperCase()),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: ChatServices().getBlockedUserStream(userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error Loading! ${snapshot.error.toString()}'),
            );
          }
          //  loading
          else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          } else {
            final blockedUsers = snapshot.data ?? [];
            //  no users
            if (blockedUsers.isEmpty) {
              return const Center(
                child: Text(
                    'No Blocked Users Found! Please Block Some Use this Functionality <3'),
              );
            }
            //  load complete
            return ListView.builder(
              itemCount: blockedUsers.length,
              itemBuilder: (context, index) {
                final user = blockedUsers[index];
                return UserTile(
                  text: user['email'],
                  onTap: () => showUnblockBox(context, user['uid']),
                );
              },
            );
          }
        },
      ),
    );
  }
}
