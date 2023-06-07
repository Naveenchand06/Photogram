import 'package:cinepebble_social/app/features/authentication/repo/auth_state_notifier.dart';
import 'package:cinepebble_social/app/features/authentication/widgets/divider_with_margins.dart';
import 'package:cinepebble_social/app/features/authentication/widgets/facebook_button.dart';
import 'package:cinepebble_social/app/features/authentication/widgets/google_button.dart';
import 'package:cinepebble_social/app/features/authentication/widgets/login_view_signup_link.dart';
import 'package:cinepebble_social/utils/app_colors.dart';
import 'package:cinepebble_social/utils/contants/strings.dart';
import 'package:flutter/material.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'cinepebble_social',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const DividerWithMargins(),
                Text(
                  Strings.logIntoYourAccount,
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
                    backgroundColor: AppColor.loginButtonColor,
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
                    backgroundColor: AppColor.loginButtonColor,
                    foregroundColor: AppColor.loginButtonTextColor,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
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
