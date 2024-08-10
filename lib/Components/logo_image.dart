import 'package:flutter/material.dart';

class LogoImage extends StatelessWidget {
  const LogoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: double.infinity,
        child: Image.asset(
          'Assets/chat2.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
