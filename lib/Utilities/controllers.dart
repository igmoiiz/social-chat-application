import 'package:flutter/cupertino.dart';

class InputControllers {
  //  input Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController textController = TextEditingController();

  //  scroll controller
  final ScrollController scrollController = ScrollController();

  //  Global Form Key Reference
  final formKey = GlobalKey<FormState>();
}
