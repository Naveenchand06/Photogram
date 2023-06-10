import 'package:cinepebble_social/app/features/authentication/repo/auth_state_notifier.dart';
import 'package:cinepebble_social/app/features/authentication/widgets/divider_with_margins.dart';
import 'package:cinepebble_social/app/features/authentication/widgets/facebook_button.dart';
import 'package:cinepebble_social/app/features/authentication/widgets/google_button.dart';
import 'package:cinepebble_social/app/features/authentication/widgets/login_view_signup_link.dart';
import 'package:cinepebble_social/utils/app_colors.dart';
import 'package:cinepebble_social/utils/contants/strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(
                //   'Welcome',
                //   style: Theme.of(context).textTheme.headlineSmall,
                // ),
                const SizedBox(
                  height: 10.0,
                ),
                CircleAvatar(
                  radius: 100.0,
                  backgroundColor: AppColor.appColor,
                  child: Text(
                    Strings.appName,
                    style: GoogleFonts.caveat(
                      fontSize: 40.0,
                      color: AppColor.whiteColor,
                    ),
                  ),
                  // backgroundImage: AssetImage('assets/profile_image.jpg'),
                ),

                // Text(
                //   Strings.appName,
                //   style: Theme.of(context)
                //       .textTheme
                //       .headlineSmall
                //       ?.copyWith(fontWeight: FontWeight.bold),
                // ),
                const DividerWithMargins(),
                Text(
                  Strings.logIntoYourAccount,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(height: 1.5),
                ),
                const SizedBox(height: 40.0),
                TextButton(
                  onPressed:
                      ref.read(authStateProvider.notifier).loginWithGoogle,
                  style: TextButton.styleFrom(
                    backgroundColor: AppColor.appColor.withOpacity(0.6),
                    foregroundColor: AppColor.loginButtonTextColor,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  child: const GoogleButton(),
                ),
                const SizedBox(height: 20.0),
                TextButton(
                  onPressed:
                      ref.read(authStateProvider.notifier).loginWithGoogle,
                  style: TextButton.styleFrom(
                    backgroundColor: AppColor.appColor.withOpacity(0.6),
                    foregroundColor: AppColor.loginButtonTextColor,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColor.whiteColor,
                    ),
                  ),
                  child: const FacebookButton(),
                ),
                const DividerWithMargins(),
                const LoginViewSignupLink()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
