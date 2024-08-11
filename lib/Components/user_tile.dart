import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const UserTile({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            //  icon
            Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * .07),
            //  username
            Text(text),
          ],
        ),
      ),
    );
  }
}
