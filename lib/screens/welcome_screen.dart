import 'package:flutter/material.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/screens/main_Screen.dart';

import '../core/services/preferences_manager.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSvgPicture.withoutColor(
                    path: "assets/images/logo.svg",
                    height: 42,
                    width: 42,
                  ),
                  SizedBox(width: 16),
                  Text(
                    "Tasky",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
              SizedBox(height: 116),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome To Tasky ",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  CustomSvgPicture.withoutColor(
                    path: "assets/images/waving_hand.svg",
                    height: 28,
                    width: 28,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                "Your productivity journey starts here.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 24),
              CustomSvgPicture.withoutColor(
                path: "assets/images/welcome.svg",
                width: 214,
                height: 200,
              ),
              SizedBox(height: 28),
              Form(
                key: _key,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        hintText: "e.g. Sarah Khalid",
                        controller: _name,
                        title: "Full Name",
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter your name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                            MediaQuery.of(context).size.width,
                            40,
                          ),
                        ),
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            await PreferencesManager().setString(
                              "name",
                              _name.value.text,
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainScreen(),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Let’s Get Started",
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
