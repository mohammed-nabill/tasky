import 'package:flutter/material.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/features/navigation/main_Screen.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/constants/storage_key.dart';
import '../../core/services/preferences_manager.dart';

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
              SizedBox(height: AppSizes.h10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSvgPicture.withoutColor(
                    path: "assets/images/logo.svg",
                    height: AppSizes.h42,
                    width: AppSizes.w42,
                  ),
                  SizedBox(width: AppSizes.w16),
                  Text(
                    "Tasky",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
              SizedBox(height: AppSizes.h116),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome To Tasky ",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  CustomSvgPicture.withoutColor(
                    path: "assets/images/waving_hand.svg",
                    height: AppSizes.h28,
                    width: AppSizes.w28,
                  ),
                ],
              ),
              SizedBox(height: AppSizes.h8),
              Text(
                "Your productivity journey starts here.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: AppSizes.h24),
              CustomSvgPicture.withoutColor(
                path: "assets/images/welcome.svg",
                width: AppSizes.w214,
                height: AppSizes.h200,
              ),
              SizedBox(height: AppSizes.h28),
              Form(
                key: _key,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.w16),
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
                      SizedBox(height: AppSizes.h24),
                      ElevatedButton(
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            await PreferencesManager().setString(
                              StorageKey.userName,
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
                            fontSize: AppSizes.sp14,
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
