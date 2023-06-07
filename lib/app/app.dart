import 'package:cinepebble_social/app/features/authentication/repo/auth_state_notifier.dart';
import 'package:cinepebble_social/app/features/authentication/views/login_view.dart';
import 'package:cinepebble_social/app/features/home/views/home_view.dart';
import 'package:cinepebble_social/app/common/providers/is_loading_provider.dart';
import 'package:cinepebble_social/utils/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<bool>(
      isLoadingProvider,
      (previous, isLoading) {
        if (isLoading == true) {
          LoadingScreen.instance().show(
            context: context,
          );
        } else {
          LoadingScreen.instance().hide();
        }
      },
    );
    final isLoggedIn = ref.watch(isLoggedInProvider);

    return SafeArea(
      child: isLoggedIn ? const HomeView() : const LoginView(),
    );
  }
}
