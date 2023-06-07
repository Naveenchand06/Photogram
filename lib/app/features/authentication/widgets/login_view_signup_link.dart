import 'package:cinepebble_social/app/common/components/rich_text_widget.dart';
import 'package:cinepebble_social/app/common/models/widget_model/base_text.dart';
import 'package:cinepebble_social/utils/contants/strings.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginViewSignupLink extends StatelessWidget {
  const LoginViewSignupLink({super.key});

  @override
  Widget build(BuildContext context) {
    return RichTextWidget(
      styleForAll:
          Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
      texts: [
        BaseText.plain(text: Strings.dontHaveAnAccount),
        // BaseText.plain(text: Strings.signUpOn),
        // BaseText.link(
        //   text: Strings.facebook,
        //   onTapped: () {
        //     launchUrl(Uri.parse(Strings.facebookSignupUrl));
        //   },
        // ),
        BaseText.plain(text: Strings.orCreateAnAccountOn),
        BaseText.link(
          text: Strings.google,
          onTapped: () {
            launchUrl(Uri.parse(Strings.googleSignupUrl));
          },
        ),
      ],
    );
  }
}
