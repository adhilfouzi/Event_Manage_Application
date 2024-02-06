import 'package:flutter/material.dart';
import 'package:project_event/model/core/font/font.dart';
import 'package:url_launcher/url_launcher.dart';

class ListTileDrawerEmail extends StatelessWidget {
  const ListTileDrawerEmail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset('assets/UI/icons/feedback.png'),
      title: Text(
        'Feedback',
        style: readexPro(),
      ),
      onTap: () async {
        const String emailAddress = 'adhilfouziofficial@gmail.com';
        const String emailSubject = 'Help_me';
        const String emailBody = 'Need_help';

        final Uri emailUri = Uri(
          scheme: 'mailto',
          path: emailAddress,
          queryParameters: {
            'subject': emailSubject,
            'body': emailBody,
          },
        );
        try {
          await launchUrl(emailUri);
        } catch (e) {
          // print('Error launching email: $e');
        }
      },
    );
  }
}
