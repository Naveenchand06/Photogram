import 'package:cinepebble_social/app/common/animations/error_animation_view.dart';
import 'package:cinepebble_social/app/common/providers/user_id_provider.dart';
import 'package:cinepebble_social/app/features/authentication/repo/auth_state_notifier.dart';
import 'package:cinepebble_social/app/features/profile/models/user_profile_model.dart';
import 'package:cinepebble_social/app/features/profile/repo/user_profile_provider.dart';
import 'package:cinepebble_social/app/features/profile/views/profile_edit_view.dart';
import 'package:cinepebble_social/app/features/profile/views/user_posts_view.dart';
import 'package:cinepebble_social/utils/app_colors.dart';
import 'package:cinepebble_social/utils/contants/strings.dart';
import 'package:cinepebble_social/utils/dialogs/alert_dialog_model.dart';
import 'package:cinepebble_social/utils/dialogs/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileView extends StatefulHookConsumerWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(userIdProvider);
    final profile = ref.watch(userProfileModelProvider(userId ?? ''));
    // : UserProfileModel(
    //     uid: uid,
    //     username: username,
    //     mobile: mobile,
    //     whatIdo: whatIdo,
    //     bio: bio,
    //     twitter: twitter,
    //     linkedin: linkedin,
    //     instagram: instagram,
    //   );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.profile,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColor.whiteColor,
                fontSize: 18.0,
              ),
        ),
        actions: [
          PopupMenuButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 1,
                  child: Text('Edit Profile'),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text('Log out'),
                ),
              ];
            },
            onSelected: (value) async {
              switch (value) {
                case 1:
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfileEditView(),
                  ));
                  break;
                case 2:
                  final shouldLogout = await const LogoutDialog()
                      .present(context)
                      .then((value) => value ?? false);
                  if (shouldLogout) {
                    ref.read(authStateProvider.notifier).logOut();
                  }
                  break;
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: profile.when(
          data: (data) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20.0),

                  const CircleAvatar(
                    radius: 64.0,
                    // backgroundImage: AssetImage('assets/profile_image.jpg'),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    data.username,
                    style: const TextStyle(
                        fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4.0),
                  if (data.mobile.isNotEmpty)
                    Text(
                      data.mobile,
                      style: const TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.w500),
                    ),
                  const SizedBox(height: 8.0),
                  if (data.whatIdo.isNotEmpty)
                    Text(
                      data.whatIdo,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600),
                    ),
                  const SizedBox(height: 16.0),
                  // const Text(
                  //   'Bio:',
                  //   style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  // ),
                  // const SizedBox(height: 8.0),
                  if (data.bio.isNotEmpty)
                    Text(
                      data.bio,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  const SizedBox(height: 16.0),
                  if (data.twitter.isNotEmpty ||
                      data.instagram.isNotEmpty ||
                      data.linkedin.isNotEmpty)
                    Column(
                      children: [
                        const SizedBox(height: 16.0),
                        const Text(
                          'Socials',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 30.0),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 70 / 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: const FaIcon(
                                  FontAwesomeIcons.twitter,
                                  color: AppColor.googleColor,
                                  size: 30.0,
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: const FaIcon(
                                  FontAwesomeIcons.linkedinIn,
                                  // color: AppColor.googleColor,
                                  size: 30.0,
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: const FaIcon(
                                  FontAwesomeIcons.instagram,
                                  // color: AppColor.googleColor,
                                  size: 30.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 30.0),
                  const UserPostsView(),
                ],
              ),
            );
          },
          error: (error, stackTrace) {
            return const ErrorAnimationView();
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
