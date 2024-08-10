import 'package:flutter/cupertino.dart';

class InputControllers {
  //  input Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  //  Global Form Key Reference
  final formKey = GlobalKey<FormState>();
}
