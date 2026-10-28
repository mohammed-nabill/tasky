import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/profile/user_details_screen.dart';
import 'package:tasky/features/welcome/welcome_screen.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/services/preferences_manager.dart';
import '../../core/widgets/custom_svg_picture.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "";
  String motivationQuote = "";
  bool isLoading = true;
  String? userImage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    setState(() {
      name = PreferencesManager().getString(StorageKey.userName) ?? '';
      motivationQuote =
          PreferencesManager().getString(StorageKey.motivationQuote) ??
          "One task at a time. One step closer.";
      userImage = PreferencesManager().getString(StorageKey.userImage);

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? CircularProgressIndicator()
        : Padding(
            padding: EdgeInsets.all(AppSizes.w16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: AppSizes.h4),
                  child: Text(
                    "My Profile",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: AppSizes.h8),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            backgroundImage: userImage == null
                                ? AssetImage('assets/images/person.png')
                                : FileImage(File(userImage!)),
                            radius: AppSizes.r60,
                            backgroundColor: Colors.transparent,
                          ),
                          GestureDetector(
                            onTap: () =>
                                _showImageSourceDialog(context, (XFile file) {
                                  _saveImage(file);
                                  setState(() {
                                    userImage = file.path;
                                  });
                                }),
                            child: Container(
                              height: AppSizes.h45,
                              width: AppSizes.w45,
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(
                                  AppSizes.r100,
                                ),
                              ),
                              child: Icon(Icons.camera_alt_outlined),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSizes.h4),
                      Text(name, style: Theme.of(context).textTheme.labelLarge),
                      Text(
                        motivationQuote,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSizes.h24),
                Text(
                  "Profile Info",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                SizedBox(height: AppSizes.h22),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () async {
                    final bool? result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return UserDetailsScreen();
                        },
                      ),
                    );
                    if (result != null && result) {
                      _loadData();
                    }
                  },
                  title: Text("User Details"),
                  leading: CustomSvgPicture(path: "assets/images/profile.svg"),
                  trailing: SvgPicture.asset(
                    "assets/images/arrow_right_icon.svg",
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.tertiary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),

                Divider(thickness: 1),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Dark Mode"),
                  leading: CustomSvgPicture(
                    path: "assets/images/dark_Icon.svg",
                  ),
                  trailing: ValueListenableBuilder(
                    valueListenable: ThemeController.themeNotifier,
                    builder: (BuildContext context, value, Widget? child) {
                      return Switch(
                        value: value == ThemeMode.dark,
                        onChanged: (bool onChanged) {
                          ThemeController.toggleTheme();
                        },
                      );
                    },
                  ),
                ),

                Divider(thickness: 1),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () async {
                    PreferencesManager().remove(StorageKey.motivationQuote);
                    PreferencesManager().remove(StorageKey.userName);
                    PreferencesManager().remove(StorageKey.tasks);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return WelcomeScreen();
                        },
                      ),
                      (route) => false,
                    );
                  },
                  title: Text("Log Out"),
                  leading: CustomSvgPicture(
                    path: "assets/images/logout_Icon.svg",
                  ),
                  trailing: SvgPicture.asset(
                    "assets/images/arrow_right_icon.svg",
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.tertiary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  void _showImageSourceDialog(
    BuildContext context,
    Function(XFile) selectedFile,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            "Choose Image Source",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          children: [
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);
                final XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) {
                  selectedFile(image);
                }
              },
              padding: EdgeInsets.all(AppSizes.w16),
              child: Row(
                children: [
                  Icon(Icons.camera_alt_outlined),
                  SizedBox(width: AppSizes.w8),
                  Text("Camera"),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);
                final XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  selectedFile(image);
                }
              },
              padding: EdgeInsets.all(AppSizes.w16),
              child: Row(
                children: [
                  Icon(Icons.photo),
                  SizedBox(width: AppSizes.w8),
                  Text("Gallery"),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _saveImage(XFile file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final newFile = await File(file.path).copy('${appDir.path}/${file.name}');
    PreferencesManager().setString(StorageKey.userImage, newFile.path);
  }
}
