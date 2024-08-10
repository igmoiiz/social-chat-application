// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class FlatButton extends StatefulWidget {
  String text;
  final iconB;
  VoidCallback onPressed;
  FlatButton({
    super.key,
    required this.iconB,
    required this.text,
    required this.onPressed,
  });

  @override
  State<FlatButton> createState() => _FlatButtonState();
}

class _FlatButtonState extends State<FlatButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: widget.onPressed,
        child: Container(
          padding: const EdgeInsets.only(left: 10),
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                widget.iconB,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                widget.text,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
