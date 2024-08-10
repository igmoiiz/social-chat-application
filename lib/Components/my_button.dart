import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttontext;
  final VoidCallback onTap;
  final bool loading;
  const MyButton({
    super.key,
    required this.buttontext,
    required this.onTap,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 16, right: 12, left: 12),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            constraints: const BoxConstraints(
              minWidth: 60,
            ),
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: loading
                ? Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  )
                : Center(
                    child: Text(
                    buttontext,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  )),
          ),
        ));
  }
}
