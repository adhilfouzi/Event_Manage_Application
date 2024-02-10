import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/controller/event_controller/profile_event/edit_profile_controller.dart';
import 'package:project_event/controller/intro_controller/login_button.dart';
import 'package:project_event/controller/services/add_image_controller.dart';
import 'package:project_event/controller/services/textvalidator.dart';
import 'package:project_event/model/data_model/profile/profile_model.dart';
import 'package:project_event/controller/widget/scaffold/app_bar.dart';
import 'package:sizer/sizer.dart';

class EditProfile extends StatelessWidget {
  final ProfileModel profile;

  const EditProfile({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImageController imagePickerController =
        Get.put(ImageController(profile.imagex));
    final TextEditingController nameController =
        TextEditingController(text: profile.name);
    final TextEditingController emailController =
        TextEditingController(text: profile.email);
    final TextEditingController phoneController =
        TextEditingController(text: profile.phone);
    final TextEditingController addressController =
        TextEditingController(text: profile.address);

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: const CustomAppBar(actions: [], titleText: 'Edit Profile'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(1.h),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 2.h),
              Obx(() {
                final imageFile = imagePickerController.imageProfile.value;
                return InkWell(
                  onTap: () => imagePickerController.openDialog(),
                  child: CircleAvatar(
                    backgroundImage: imageFile != null
                        ? FileImage(imageFile)
                        : const AssetImage('assets/UI/icons/profile.png')
                            as ImageProvider,
                    radius: 50.0,
                    backgroundColor: Colors.white,
                  ),
                );
              }),
              TextValidator().nameController(nameController: nameController),
              TextValidator().emailTextField(emailController),
              TextValidator().phoneNumber(phoneController: phoneController),
              TextValidator().normal(
                  controller: addressController, textcontent: 'Address'),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: firstbutton(),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Profile.editProfileController(
                            formKey,
                            profile,
                            nameController,
                            emailController,
                            phoneController,
                            addressController,
                            imagePickerController.imageProfile.value?.path,
                          );
                        }
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
    );
  }
}
