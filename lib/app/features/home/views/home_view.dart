import 'package:cinepebble_social/app/features/posts/models/file_type.dart';
import 'package:cinepebble_social/app/features/posts/repo/post_setting_provider.dart';
import 'package:cinepebble_social/app/features/posts/views/create_post_view.dart';
import 'package:cinepebble_social/utils/app_colors.dart';
import 'package:cinepebble_social/utils/helpers/image_upload_helper.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeView> {
  int _currentIndex = 0;
  final List<Widget> _screens = const [
    // ExploreScreen(),
    Center(child: Icon(Icons.home_outlined)),
    Center(child: Icon(Icons.favorite)),
    Center(child: Icon(Icons.person_2)),

    // ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cinepebble',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColor.whiteColor,
              fontSize: 20.0),
        ),
      ),
      body: _screens[_currentIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.appColor,
        onPressed: () async {
          final imageFile = await ImagePickerHelper.pickImageFromGallery();
          if (imageFile == null) {
            return;
          }

          ref.refresh(postSettingProvider);

          // Go to the screen to create a new post
          if (!mounted) {
            return;
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CreatePostView(
                  fileToPost: imageFile, fileType: FileType.image),
            ),
          );
        },
        child: const Icon(Icons.create_new_folder_rounded),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(8.0),
        height: 73.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: BottomNavigationBar(
            iconSize: 24.0,
            currentIndex: _currentIndex,
            backgroundColor: AppColor.appColor,
            elevation: 1.0,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            selectedFontSize: 28.0,
            selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
            selectedLabelStyle: const TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
            selectedIconTheme: const IconThemeData(
              color: AppColor.whiteColor,
            ),
            unselectedIconTheme: const IconThemeData(
              color: AppColor.whiteColor,
            ),
            showSelectedLabels: true,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: '•',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: '•',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_2_rounded),
                label: '•',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
