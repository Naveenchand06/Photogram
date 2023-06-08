import 'package:cinepebble_social/app/common/components/common_button.dart';
import 'package:cinepebble_social/app/common/components/common_text_field.dart';
import 'package:cinepebble_social/utils/app_colors.dart';
import 'package:cinepebble_social/utils/contants/profile_strings.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 64.0,
                // backgroundImage: AssetImage('assets/profile_image.jpg'),
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
                onPress: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
