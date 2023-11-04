import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/font.dart';

class Terms extends StatelessWidget {
  const Terms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(children: [
            Text(
              'Terms of Service',
              style: readexPro(),
            ),
            const SizedBox(height: 10),
            Text(
              'Please read these Terms of Use carefully before using the Application which developed by Visionary Labs. These Terms apply to all users and others who use the App. By using the App you agree to be bound by these Terms. If you disagree the terms then you may not use the App. You agree that you will not use the Application Service for any illegal purposes, including but not limited to the pirating or illegal distribution of software. You agree that you will not attempt to access areas and information that you are not authorized to access.',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 15),
            Text(
              'Limited Liability',
              style: readexPro(),
            ),
            const SizedBox(height: 10),
            Text(
              'You accept that; Visionary Labs do not have any sort of liability what so ever for anything that may arise from the use of our apps. ',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 15),
            Text(
              'Termination ',
              style: readexPro(),
            ),
            const SizedBox(height: 10),
            Text(
              'We may terminate or suspend access to our Service immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the Terms ',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 15),
            Text(
              'Redirects to other Web SItes',
              textAlign: TextAlign.center,
              style: readexPro(),
            ),
            const SizedBox(height: 10),
            Text(
              'Our Service may contain links to third-party web sites or services that are not owned or controlled by Visionary Labs. Visionary Labs has no control over, and assumes no responsibility for, the content, privacy policies, or practices of any third party web sites or services. You further acknowledge and agree that Visionary Labs shall not be responsible or liable, directly or indirectly, for any damage or loss caused or alleged to be caused by or in connection with use of or reliance on any such content, goods or services available on or through any such web sites or services. We strongly advise you to read the terms and conditions and privacy policies of any third-party web sites or services that you visit.',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 15),
            Text(
              'Changes',
              textAlign: TextAlign.center,
              style: readexPro(),
            ),
            const SizedBox(height: 10),
            Text(
              'We also reserve the right at any time to modify or discontinue the Service, temporarily or permanently, with or without notice to you. If you do not agree to the new terms, please stop using the Service.',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 15),
            Text(
              'Support',
              textAlign: TextAlign.center,
              style: readexPro(),
            ),
            const SizedBox(height: 10),
            Text(
              'We always try to fix the Application issue but as some of the our apps depends on phone hardware So we might We might not be able to solve the issue is related to phone Hardware OR if you upgrade to a new Android Phone OR You Change your phone to different one, In this case you change your device your old phone application will be not be able to transfer old Phone Data/Settings to your new Phone automatically you can try with share feature of the app manually.',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.blueAccent)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
