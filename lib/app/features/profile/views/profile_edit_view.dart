import 'package:cinepebble_social/app/common/animations/error_animation_view.dart';
import 'package:cinepebble_social/app/common/components/common_button.dart';
import 'package:cinepebble_social/app/common/components/common_text_field.dart';
import 'package:cinepebble_social/app/common/providers/user_id_provider.dart';
import 'package:cinepebble_social/app/features/posts/models/file_type.dart';
import 'package:cinepebble_social/app/features/profile/models/profile_payload.dart';
import 'package:cinepebble_social/app/features/profile/repo/profile_image_upload_provider.dart';
import 'package:cinepebble_social/app/features/profile/repo/update_user_profile_provider.dart';
import 'package:cinepebble_social/app/features/profile/repo/user_profile_provider.dart';
import 'package:cinepebble_social/utils/app_colors.dart';
import 'package:cinepebble_social/utils/contants/profile_strings.dart';
import 'package:cinepebble_social/utils/helpers/image_upload_helper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ProfileEditView extends StatefulHookConsumerWidget {
  const ProfileEditView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfileEditViewState();
}

class _ProfileEditViewState extends ConsumerState<ProfileEditView> {
  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(userIdProvider);
    final profile = ref.watch(userProfileModelProvider(userId ?? ''));

    final usernameController = useTextEditingController();
    final whatIdoController = useTextEditingController();
    final bioController = useTextEditingController();
    final mobileController = useTextEditingController();
    final twitterController = useTextEditingController();
    final linkedinController = useTextEditingController();
    final instagramController = useTextEditingController();

    useEffect(() {}, [
      usernameController,
      whatIdoController,
      bioController,
      mobileController,
      twitterController,
      instagramController,
      linkedinController,
    ]);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Profile',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColor.whiteColor,
                fontSize: 18.0),
          ),
        ),
        body: profile.when(
          data: (data) {
            usernameController.text = data.username;
            mobileController.text = data.mobile;
            whatIdoController.text = data.whatIdo;
            bioController.text = data.bio;
            twitterController.text = data.twitter;
            instagramController.text = data.instagram;
            linkedinController.text = data.linkedin;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final imageFile =
                            await ImagePickerHelper.pickImageFromGallery();
                        if (imageFile == null) {
                          return;
                        }
                        ref.read(profileImageUploadProvider.notifier).upload(
                            file: imageFile,
                            fileType: FileType.image,
                            userId: userId ?? '');
                      },
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 64.0,
                            backgroundColor: AppColor.appColor,

                            child: Image.network(
                              '',
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.person,
                                  size: 50.0,
                                  color: AppColor.whiteColor,
                                );
                              },
                            ),
                            // backgroundImage: AssetImage('assets/profile_image.jpg'),
                          ),
                          // CircleAvatar(
                          //   radius: 64.0,
                          //   backgroundColor: Colors.transparent,
                          //   child: Center(
                          //     child: Column(
                          //       mainAxisAlignment: MainAxisAlignment.end,
                          //       mainAxisSize: MainAxisSize.min,
                          //       children: const [
                          //         // Icon(Icons.camera),
                          //         Text(
                          //           '\n\n\nEdit Profile',
                          //           style:
                          //               TextStyle(color: AppColor.whiteColor),
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    CommonTextField(
                      fieldname: ProfileStrings.username,
                      hintText: ProfileStrings.usernameHint,
                      fieldController: usernameController,
                    ),
                    CommonTextField(
                      fieldname: ProfileStrings.whatIdo,
                      hintText: ProfileStrings.whatIdoHint,
                      fieldController: whatIdoController,
                    ),
                    CommonTextField(
                      fieldname: ProfileStrings.bio,
                      hintText: ProfileStrings.bioHint,
                      fieldController: bioController,
                      maxLines: 3,
                    ),
                    CommonTextField(
                      fieldname: ProfileStrings.phone,
                      hintText: ProfileStrings.phoneHint,
                      fieldController: mobileController,
                    ),
                    CommonTextField(
                      fieldname: ProfileStrings.twitter,
                      hintText: ProfileStrings.enterTheLink,
                      fieldController: twitterController,
                    ),
                    CommonTextField(
                      fieldname: ProfileStrings.insta,
                      hintText: ProfileStrings.enterTheLink,
                      fieldController: instagramController,
                    ),
                    CommonTextField(
                      fieldname: ProfileStrings.linkedin,
                      hintText: ProfileStrings.enterTheLink,
                      fieldController: linkedinController,
                    ),
                    const SizedBox(height: 12.0),
                    CommonButton(
                      buttonTitle: 'SAVE',
                      onPress: () async {
                        debugPrint(
                            'The username is ---> ${usernameController.text}');
                        debugPrint(
                            'The mobile is ---> ${mobileController.text}');
                        final userId = ref.read(userIdProvider);
                        if (userId != null) {
                          ProfilePayload updated = ProfilePayload(
                            uid: userId,
                            username: usernameController.text.trim(),
                            mobile: mobileController.text.trim(),
                            whatIdo: whatIdoController.text.trim(),
                            bio: bioController.text.trim(),
                            twitter: twitterController.text.trim(),
                            linkedin: linkedinController.text.trim(),
                            instagram: instagramController.text.trim(),
                          );
                          debugPrint('The profile Payload is ===> ${updated}');
                          ref.read(updateUserProfileProvider(updated));
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          error: (error, stackTrace) {
            return const ErrorAnimationView();
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColor.appColor,
              ),
            );
          },
        ));
  }
}
