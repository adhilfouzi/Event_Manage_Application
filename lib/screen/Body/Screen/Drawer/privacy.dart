import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/font.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(children: [
            Text(
              'PRIVACY & POLICY',
              style: readexPro(),
            ),
            const SizedBox(height: 10),
            Text(
              'At Visionary Labs we recognize that privacy is significant. This Privacy Policy applies to all Android apps under the publisher name of Visionary Labs. We has created this Policy to explain our privacy practices so you can understand what information about you is collected, used and disclosed. We collect information from you in order to provide corresponding service and better user experience. With your consent of this Privacy Policy, your usage, statistics, input while using our apps would be collected.',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 15),
            Text(
              'Information Collection and Use',
              style: readexPro(),
            ),
            const SizedBox(height: 10),
            Text(
              'We store your profiles data on your device only, we don?t store them on our server. We may collect Non-Personal Information about users whenever they interact with our application. Non-Personal Information is in a form that does not, on its own, permit direct association with any specific individual, which may include the information about your devices, including the list of installed apps on your devices, the versions of phone model and other similar information. We may collect and store details of how you use our services, which may be used to improve the relevancy of results provided by our services.',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 15),
            Text(
              'EU USER CONSENT POLICY',
              style: readexPro(),
            ),
            const SizedBox(height: 10),
            Text(
              'We include certain disclosures to users in the European Economic Area (EEA) & obtain their consent to use cookies or other local storage, where legally required, and to use personal data (such as AdID) to serve ads. This policy reflects the requirements of the EU ePrivacy Directive and the General Data Protection Regulation (GDPR).\nWe ask about permission of users which are in EEA(European Economic Area) to display ads like PERSONALIZE/NON-PERSONALIZ',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 15),
            Text(
              'PRIVACY POLICY OF THIRD PARTY SERVICE PROVIDERS USED BY THE APP',
              textAlign: TextAlign.center,
              style: readexPro(),
            ),
            const SizedBox(height: 10),
            Text(
              'For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information. The information that I request is retained on your device and is not collected by me in any wayThe app does use third party services that may collect information used to identify you.',
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
