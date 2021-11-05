import 'dart:io';

import 'package:flutter_mailer/flutter_mailer.dart';

class mailApi {
  static Future<String> sendMail(File file) async {
    final MailOptions mailOptions = MailOptions(
      body: 'A long body for the email <br>',
      subject: 'This is the subject',
      recipients: ['example@example.com'],
      isHTML: true,
      bccRecipients: ['other@example.com'],
      ccRecipients: ['third@example.com'],
      attachments: [
        '${file.path}',
      ],
    );

    final MailerResponse response = await FlutterMailer.send(mailOptions);
    print(response.toString());
  }
}
