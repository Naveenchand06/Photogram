import 'package:cinepebble_social/app/features/profile/views/profile_edit_view.dart';
import 'package:cinepebble_social/utils/app_colors.dart';
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
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Profile'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20.0),

              const CircleAvatar(
                radius: 64.0,
                // backgroundImage: AssetImage('assets/profile_image.jpg'),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'John Doe',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4.0),
              const Text(
                '9876543210',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Software Developer',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16.0),
              // const Text(
              //   'Bio:',
              //   style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              // ),
              // const SizedBox(height: 8.0),
              const Text(
                'I am a passionate developer who loves coding and building amazing apps.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 16.0),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfileEditView(),
                  ));
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profile'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(8.0),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Socials',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 70 / 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: FaIcon(
                        FontAwesomeIcons.twitter,
                        color: AppColor.googleColor,
                        size: 30.0,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: FaIcon(
                        FontAwesomeIcons.linkedinIn,
                        // color: AppColor.googleColor,
                        size: 30.0,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: FaIcon(
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
        ),
      ),
    );
  }
}
