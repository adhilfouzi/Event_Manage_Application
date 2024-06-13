import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/controller/event_controller/event/add_event_controller.dart';
import 'package:project_event/controller/services/textvalidator.dart';
import 'package:project_event/controller/widget/scaffold/app_bar.dart';
import 'package:project_event/model/core/color/color.dart';
import 'package:project_event/model/core/font/font.dart';

import 'package:project_event/view/body_screen/main/main_screem.dart';
import 'package:project_event/controller/widget/sub/contact_form_widget.dart';
import 'package:project_event/controller/widget/sub/date_widget.dart';
import 'package:project_event/controller/widget/sub/fn_time.dart';
import 'package:sizer/sizer.dart';

class AddEvent extends StatelessWidget {
  final int profileid;

  const AddEvent({Key? key, required this.profileid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddEventController controller =
        Get.put(AddEventController(profileid));

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Get.offAll(
          transition: Transition.leftToRightWithFade,
          fullscreenDialog: true,
          MainBottom(profileid: profileid),
        );
      },
      child: Scaffold(
        appBar: CustomAppBar(
          actions: [
            AppAction(
              icon: Icons.contacts,
              onPressed: () {
                controller.getContact();
              },
            ),
          ],
          titleText: ' ',
        ),
        body: Obx(() {
          final imageEvent = controller.imageEvent.value;
          final formKey = controller.formKey;
          bool clientDetailsVisible = controller.hasClient.value;

          return SingleChildScrollView(
            padding: EdgeInsets.all(0.5.h),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    'Event Details',
                    style: raleway(fontSize: 18.sp),
                  ),
                  Divider(
                    color: buttoncolor,
                    height: 1.h,
                    thickness: 2,
                    endIndent: 40,
                    indent: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(1.h, 1.h, 1.h, 1.h),
                    child: InkWell(
                      onTap: () {
                        controller.addPhoto();
                      },
                      child: SizedBox(
                        width: double.infinity,
                        height:
                            imageEvent == null ? 18.h : 25.h, // Adjusted height
                        child: Card(
                          color: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: imageEvent == null
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/UI/icons/addimage.png',
                                          height: 10.h,
                                        ),
                                        Text(
                                          'Add image of event',
                                          style: raleway(color: Colors.black),
                                        )
                                      ],
                                    ),
                                  )
                                : Image.file(
                                    imageEvent,
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextValidator().nameController(
                      nameController: controller.eventNameController),
                  TextValidator()
                      .budget(budgetController: controller.budgetController),
                  TextValidator().place(
                      controller: controller.locationController,
                      textcontent: 'Place',
                      bool: true),
                  TextValidator().normal(
                      controller: controller.aboutController,
                      textcontent: 'About'),
                  Date(
                    textdate: 'Event Day',
                    controller: controller.startDateController,
                  ),
                  Time(
                    textdate: 'Event Time',
                    controller: controller.startTimeController,
                  ),
                  CheckboxListTile(
                    title: const Text('Do you have a client?'),
                    value: clientDetailsVisible,
                    onChanged: (value) {
                      controller.hasClient.value = value!;
                    },
                  ),
                  if (clientDetailsVisible) ...[
                    Text(
                      'Client Details',
                      style: raleway(fontSize: 18.sp),
                    ),
                    Divider(
                      color: buttoncolor,
                      height: 2.h,
                      thickness: 2,
                      endIndent: 40,
                      indent: 40,
                    ),
                    SizedBox(height: 2.h),
                    TextValidator().normal(
                        controller: controller.clientNameController,
                        textcontent: 'Client Name'),
                    ContactState(
                      acontroller: controller.addressController,
                      econtroller: controller.emailController,
                      pcontroller: controller.phoneNumberController,
                    ),
                    SizedBox(height: 2.h),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
                              vertical: 1.h, horizontal: 10.h)),
                          side: WidgetStateProperty.all(BorderSide.none),
                          backgroundColor: WidgetStateProperty.all(buttoncolor),
                        ),
                        autofocus: true,
                        onPressed: () {
                          controller.addEventClicked();
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
