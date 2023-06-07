import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/screens/features/onboarding/interests_screen.dart';

import 'widgets/form_btn.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();

  DateTime initialDate = DateTime.now();

/*   Code Challenge! DO NOT ENTER CHILD hehe!
  late DateTime doNotEnterChild =
      DateTime(initialDate.year - 19, initialDate.month, initialDate.day); */

  @override
  void initState() {
    super.initState();
    _setTextFieldDate(initialDate);
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
  }

  void _onNextTap() {
    Navigator.of(context).pushAndRemoveUntil(
        //push를 사용하지 않는 이유는 다른 창에서 로그인 창으로 돌아가지 않기 하기 위해
        MaterialPageRoute(
          builder: (context) => const InterestScreen(),
        ),
        (route) => false);
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    _birthdayController.value = TextEditingValue(text: textDate);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Sign up",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "When is your birthday?",
                        style: TextStyle(
                          fontSize: Sizes.size20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Gaps.v14,
                      Text(
                        "Your birthday won't be shown publicity.",
                        style: TextStyle(
                          fontSize: Sizes.size14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const FaIcon(
                    FontAwesomeIcons.cakeCandles,
                    size: Sizes.size56,
                    color: Colors.grey,
                  )
                ],
              ),
              Gaps.v28,
              TextField(
                enabled: false,
                controller: _birthdayController,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v28,
              GestureDetector(
                  onTap: _onNextTap,
                  child: const FormBtn(
                    disabled: false,
                    text: "Submit",
                  ))
            ],
          ),
        ),
        bottomNavigationBar: Container(
          child: SizedBox(
            height: 220,
            child: CupertinoDatePicker(
              maximumDate: initialDate,
              initialDateTime: initialDate,
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: _setTextFieldDate,
            ),
          ),
        ),
      ),
    );
  }
}
