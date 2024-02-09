import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_event/controller/intro_controller/login_button.dart';
import 'package:project_event/model/db_functions/fn_profilemodel.dart';
import 'package:project_event/model/data_model/profile/profile_model.dart';
import 'package:project_event/controller/widget/box/textfield_blue.dart';
import 'package:project_event/controller/widget/scaffold/app_bar.dart';
import 'package:project_event/model/getx/snackbar/getx_snackbar.dart';
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
  File? imageprofile;
  String? imagepath;
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
                  onTap: () => addonEditPhoto(),
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
                          editProfileClicked();
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

  Future editProfileClicked() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final existingProfiles = profileList.value
          .where((profile) => profile.email == emailController.text)
          .toList();

      if (emailController.text != widget.profileid.email) {
        if (existingProfiles.isNotEmpty) {
          SnackbarModel.errorSnack(message: 'This email is already registered');
          return;
        }
      }

      if (imagepath == null) {
        SnackbarModel.errorSnack(message: 'Forgot to add an image');
        return;
      }

      await editProfiledata(
        widget.profileid.id,
        imagepath,
        nameController.text.toUpperCase(),
        emailController.text.toLowerCase(),
        phoneController.text,
        addressPassController.text,
        widget.profileid.password,
      );

      refreshRefreshid(widget.profileid.id!);
      Get.back();
    }
  }

  // Future editProfilecliked(context) async {
  //   SnackbarModel ber = SnackbarModel();

  //   if (_formKey.currentState != null && _formKey.currentState!.validate()) {
  //     final existingProfiles = profileList.value
  //         .where((profile) => profile.email == emailController.text)
  //         .toList();
  //     if (emailController.text != widget.profileid.email) {
  //       if (existingProfiles.isNotEmpty) {
  //         ber.errorSnack(message: 'This email is already registered');
  //         return;
  //       }
  //     }
  //     if (imagepath == null) {
  //       ber.errorSnack(message: "forget to add image");
  //     }
  //     await editProfiledata(
  //         widget.profileid.id,
  //         imagepath,
  //         nameController.text.toUpperCase(),
  //         emailController.text.toLowerCase(),
  //         phoneController.text,
  //         addressPassController.text,
  //         widget.profileid.password);
  //     refreshRefreshid(widget.profileid.id!);
  //     Get.back();
  //   }
  // }

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

  void addonEditPhoto() {
    Get.defaultDialog(
      title: '',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Choose Image From.......',
            style: TextStyle(fontSize: 12.sp),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
          ),
        ],
      ),
    );
  }
}
