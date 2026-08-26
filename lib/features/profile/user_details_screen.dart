import 'package:flutter/material.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';

import '../../core/services/preferences_manager.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late String name;
  late String motivationQuote;
  bool isLoadingName = true;
  bool isLoadingMotivationQuote = true;
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController motivationQuoteController =
      TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _getName();
    _getMotivationQuote();
  }

  void _getName() async {
    setState(() {
      name = PreferencesManager().getString("name") ?? '';
      userNameController.value = TextEditingValue(text: name);
      isLoadingName = false;
    });
  }

  void _getMotivationQuote() async {
    setState(() {
      motivationQuote =
          PreferencesManager().getString("motivationQuote") ??
          "One task at a time. One step closer.";
      motivationQuoteController.value = TextEditingValue(text: motivationQuote);
      isLoadingMotivationQuote = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(titleSpacing: 0, title: Text("User Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              isLoadingName
                  ? CircularProgressIndicator()
                  : CustomTextFormField(
                      hintText: name,
                      controller: userNameController,
                      title: "User Name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter User Name";
                        }
                        return null;
                      },
                    ),
              SizedBox(height: 20),
              isLoadingMotivationQuote
                  ? CircularProgressIndicator()
                  : CustomTextFormField(
                      hintText: motivationQuote,
                      controller: motivationQuoteController,
                      title: "Motivation Quote",
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Motivation Quote";
                        }
                        return null;
                      },
                    ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                ),
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    await PreferencesManager().setString(
                      "name",
                      userNameController.text,
                    );
                    await PreferencesManager().setString(
                      "motivationQuote",
                      motivationQuoteController.text,
                    );
                    Navigator.of(context).pop(true);
                  }
                },
                child: Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
