import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:url_launcher/url_launcher.dart';

class ListTileDrawer extends StatelessWidget {
  final Widget map;
  final String imagedata;
  final String textdata;
  const ListTileDrawer(
      {super.key,
      required this.imagedata,
      required this.textdata,
      required this.map});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(imagedata),
      title: Text(
        textdata,
        style: readexPro(),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => map));
      },
    );
  }
}

class ListTileDrawerUrl extends StatelessWidget {
  final Function()? link;
  final String imagedata;
  final String textdata;
  const ListTileDrawerUrl(
      {super.key,
      required this.imagedata,
      required this.textdata,
      required this.link});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(imagedata),
      title: Text(
        textdata,
        style: readexPro(),
      ),
      onTap: () async {
        if (link != null) {
          await link!();
        }
      },
    );
  }
}

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
          print('Error launching email: $e');
        }
      },
    );
  }
}
