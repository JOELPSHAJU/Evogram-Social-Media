import 'package:evogram/application/core/constants.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/text_styles.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 30,
        shadowColor: Theme.of(context).brightness == Brightness.light ? white : grey80,
        backgroundColor:
            Theme.of(context).brightness == Brightness.light ? white : black,
        surfaceTintColor:
            Theme.of(context).brightness == Brightness.light ? white : black,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        title: appbarTitle(title: 'Privacy Policies'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            h10,
            const Text(
              'This privacy policy applies to the Interact app (hereby referred to as "Application") for mobile devices that was created by Joel P Shaju (hereby referred to as "Service Provider") as a Free service. This service is intended for use "AS IS".',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14, color: grey),
            ),
            h10,
            const Text(
              'Information Collection and Use',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            h10,
            const Text(
              'The Application collects information when you download and use it. This information may include information such as.',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14, color: grey),
            ),
            h10,
            const Text(
              '''◉ Your device's Internet Protocol address (e.g. IP address)''',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14, color: grey),
            ),
            h10,
            const Text(
              '''◉ The pages of the Application that you visit, the time and date of your visit, the time spent on those pages''',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14, color: grey),
            ),
            h10,
            const Text(
              '''◉ The time spent on the Application''',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14, color: grey),
            ),
            h10,
            const Text(
              '''◉ The operating system you use on your mobile device''',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14, color: grey),
            ),
            h10,
            const Text(
              'The Application does not gather precise information about the location of your mobile device',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14, color: grey),
            ),
            h10,
            const Text(
              'The Service Provider may use the information you provided to contact you from time to time to provide you with important information, required notices and marketing promotions.',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14, color: grey),
            ),
            h10,
            const Text(
              'For a better experience, while using the Application, the Service Provider may require you to provide us with certain personally identifiable information. The information that the Service Provider request will be retained by them and used as described in this privacy policy.',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14, color: grey),
            ),
            h10,
            const Text(
              'Third Party Access',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            h10,
            h10,
            const Text(
              'Only aggregated, anonymized data is periodically transmitted to external services to aid the Service Provider in improving the Application and their service. The Service Provider may share your information with third parties in the ways that are described in this privacy statement.',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14, color: grey),
            ),
            h10,
            const Text(
              'The Service Provider may disclose User Provided and Automatically Collected Information:',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14, color: grey),
            ),
            h10,
            const Text(
              '''◉ as required by law, such as to comply with a subpoena, or similar legal process;''',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14, color: grey),
            ),
            h10,
            const Text(
              '''◉ when they believe in good faith that disclosure is necessary to protect their rights, protect your safety or the safety of others, investigate fraud, or respond to a government request;''',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14, color: grey),
            ),
            h10,
            const Text(
              '''◉ with their trusted services providers who work on their behalf, do not have an independent use of the information we disclose to them, and have agreed to adhere to the rules set forth in this privacy statement''',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14, color: grey),
            ),
            h10,
            const Text(
              '''Opt-Out Rights''',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            h10,
            const Text(
              'You can stop all collection of information by the Application easily by uninstalling it. You may use the standard uninstall processes as may be available as part of your mobile device or via the mobile application marketplace or network.',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14, color: grey),
            ),
            h10,
            const Text(
              'Data Retention Policy',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            h10,
            const Text(
              '''The Service Provider will retain User Provided data for as long as you use the Application and for a reasonable time thereafter. If you'd like them to delete User Provided Data that you have provided via the Application, please contact them at ribinrajop@gmail.com and they will respond in a reasonable time.''',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14, color: grey),
            ),
            h10,
            const Text(
              'Children',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            h10,
            const Text(
              '''The Service Provider does not use the Application to knowingly solicit data from or market to children under the age of 13. The Service Provider does not knowingly collect personally identifiable information from children. The Service Provider encourages all children to never submit any personally identifiable information through the Application and/or Services. The Service Provider encourage parents and legal guardians to monitor their children's Internet usage and to help enforce this Policy by instructing their children never to provide personally identifiable information through the Application and/or Services without their permission. If you have reason to believe that a child has provided personally identifiable information to the Service Provider through the Application and/or Services, please contact the Service Provider (ribinrajop@gmail.com) so that they will be able to take the necessary actions. You must also be at least 16 years of age to consent to the processing of your personally identifiable information in your country (in some countries we may allow your parent or guardian to do so on your behalf).''',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14, color: grey),
            ),
            h10,
            const Text(
              'Security',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            h10,
            const Text(
              '''The Service Provider is concerned about safeguarding the confidentiality of your information. The Service Provider provides physical, electronic, and procedural safeguards to protect information the Service Provider processes and maintains.''',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14, color: grey),
            ),
            h10,
            const Text(
              'Changes',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            h10,
            const Text(
              '''This Privacy Policy may be updated from time to time for any reason. The Service Provider will notify you of any changes to the Privacy Policy by updating this page with the new Privacy Policy. You are advised to consult this Privacy Policy regularly for any changes, as continued use is deemed approval of all changes.''',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14, color: grey),
            ),
            h10,
            const Text(
              'This privacy policy is effective as of 16-05-24',
              style: TextStyle(fontSize: 15.0, color: grey),
            ),
            h10,
            const Text(
              'Your Consent',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            h10,
            const Text(
              '''By using the Application, you are consenting to the processing of your information as set forth in this Privacy Policy now and as amended by us.''',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14, color: grey),
            ),
            h10,
            const Text(
              'Contact Us',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            RichText(
              text: TextSpan(
                  text:
                      'If you have any questions regarding privacy while using the Application, or have questions about the practices, please contact the Service Provider via; \n',
                  // ignore: prefer_const_constructors
                  style: GoogleFonts.inter(
                      fontSize: 13, fontWeight: FontWeight.w400, color: grey),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          'Email: joelpshaju@gmail.com\nContact: +91 8590182736',
                      style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: blue),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
