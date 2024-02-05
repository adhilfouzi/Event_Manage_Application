import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_event/database/functions/fn_profilemodel.dart';
import 'package:project_event/database/model/profile/profile_model.dart';
import 'package:project_event/screen/body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/body/widget/scaffold/app_bar.dart';

import 'package:project_event/screen/intro/loginpage.dart';
import 'package:sizer/sizer.dart';

class EditProfile extends StatefulWidget {
  final ProfileModel profileid;

  const EditProfile({super.key, required this.profileid});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController addressPassController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String? imagepath;
  File? imageprofile;

  @override
  void initState() {
    super.initState();
    addressPassController.text = widget.profileid.address ?? '';
    emailController.text = widget.profileid.email;
    phoneController.text = widget.profileid.phone;
    nameController.text = widget.profileid.name;
    if (widget.profileid.imagex != null) {
      imagepath = widget.profileid.imagex;
      imageprofile = File(imagepath!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const CustomAppBar(actions: [], titleText: 'Edit Profile'),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(1.h),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 2.h),
                InkWell(
                  onTap: () => addoneditphoto(context),
                  child: CircleAvatar(
                    backgroundImage: imageprofile != null
                        ? FileImage(imageprofile!)
                        : const AssetImage('assets/UI/icons/profile.png')
                            as ImageProvider,
                    radius: 50.0,
                    backgroundColor: Colors.white,
                  ),
                ),
                TextFieldBlue(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Name';
                    }
                    if (value.length >= 16) {
                      return "Name is too long";
                    }
                    return null;
                  },
                  textcontent: 'Full Name',
                  keyType: TextInputType.name,
                  controller: nameController,
                ),
                // SizedBox(height: 1.h),
                TextFieldBlue(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a valid email address';
                    }
                    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                        .hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                  textcontent: 'Email',
                  keyType: TextInputType.emailAddress,
                  controller: emailController,
                ),
                // SizedBox(height: 1.h),
                TextFieldBlue(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a valid phone number';
                    }
                    final phoneNumberWithoutSpaces = value.replaceAll(' ', '');

                    if (phoneNumberWithoutSpaces.startsWith('+') &&
                        phoneNumberWithoutSpaces.length >= 13) {
                      return null;
                    } else if (!phoneNumberWithoutSpaces.startsWith('+') &&
                        phoneNumberWithoutSpaces.length == 10) {
                      return null;
                    } else {
                      return 'Enter a valid phone number';
                    }
                  },
                  textcontent: 'Phone Number',
                  keyType: TextInputType.number,
                  controller: phoneController,
                ),
                TextFieldBlue(
                  keyType: TextInputType.streetAddress,
                  controller: addressPassController,
                  textcontent: 'Address',
                  posticondata: Icons.location_on,
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: firstbutton(),
                        onPressed: () {
                          editProfilecliked(context);
                        },
                        child: Text(
                          'Update',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future editProfilecliked(context) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final existingProfiles = profileList.value
          .where((profile) => profile.email == emailController.text)
          .toList();
      if (emailController.text != widget.profileid.email) {
        if (existingProfiles.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('This email is already registered'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }
      }

      await editProfiledata(
          widget.profileid.id,
          imagepath,
          nameController.text.toUpperCase(),
          emailController.text.toLowerCase(),
          phoneController.text,
          addressPassController.text,
          widget.profileid.password);
      refreshRefreshid(widget.profileid.id!);
      Get.back();
    }
  }

  Future<void> getimage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return;
      }
      setState(() {
        imageprofile = File(image.path);
        imagepath = image.path; // Remove toString() here
      });
    } catch (e) {
      // print('Failed image picker: $e');
    }
  }

  void addoneditphoto(ctx) {
    showDialog(
      context: ctx,
      builder: (ctx) {
        return AlertDialog(
          content: const Text('Choose Image From.......'),
          actions: [
            IconButton(
              onPressed: () {
                getimage(ImageSource.camera);
                Get.back();
              },
              icon: const Icon(
                Icons.camera_alt_rounded,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: () {
                getimage(ImageSource.gallery);
                Get.back();
              },
              icon: const Icon(
                Icons.image,
                color: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }
}
