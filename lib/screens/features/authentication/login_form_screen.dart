import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/screens/features/authentication/widgets/form_btn.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Log in",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size40,
        ),
        child: Form(
          child: Column(
            children: [
              TextFormField(),
              Gaps.v16,
              TextFormField(),
              Gaps.v28,
              const FormBtn(
                disabled: false,
                text: "Log in",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
