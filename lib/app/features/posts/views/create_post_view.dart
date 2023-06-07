import 'dart:io';

import 'package:cinepebble_social/app/common/components/common_button.dart';
import 'package:cinepebble_social/app/common/components/file_thumbnail_view.dart';
import 'package:cinepebble_social/app/common/providers/user_id_provider.dart';
import 'package:cinepebble_social/app/features/posts/models/file_type.dart';
import 'package:cinepebble_social/app/features/posts/models/post_setting.dart';
import 'package:cinepebble_social/app/features/posts/models/thumbnail_request.dart';
import 'package:cinepebble_social/app/features/posts/repo/image_upload_provider.dart';
import 'package:cinepebble_social/app/features/posts/repo/post_setting_provider.dart';
import 'package:cinepebble_social/app/features/posts/widgets/browse_gallery_button.dart';
import 'package:cinepebble_social/utils/app_colors.dart';
import 'package:cinepebble_social/utils/contants/strings.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CreatePostView extends StatefulHookConsumerWidget {
  final File fileToPost;
  final FileType fileType;

  const CreatePostView({
    super.key,
    required this.fileToPost,
    required this.fileType,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends ConsumerState<CreatePostView> {
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;

    final thumbnailRequest = ThumbnailRequest(
      file: widget.fileToPost,
      fileType: widget.fileType,
    );

    final postSettings = ref.watch(postSettingProvider);

    final postController = useTextEditingController();
    final isPostButtonEnabled = useState(false);

    useEffect(() {
      void listener() {
        isPostButtonEnabled.value = postController.text.isNotEmpty;
      }

      postController.addListener(listener);
      return () {
        postController.removeListener(listener);
      };
    }, [postController]);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColor.whiteColor,
              fontSize: 18.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: FileThumbnailView(thumbnailRequest: thumbnailRequest),
              ),

              // Container(
              //   padding: const EdgeInsets.all(8.0),
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(14.0),
              //       boxShadow: const [
              //         // BoxShadow(color: Colors.grey, offset: Offset(5, -3))
              //       ]),
              //   child: Column(
              //     children: [
              //       Container(
              //         height: sh * 60 / 100,
              //         width: double.infinity,
              //         alignment: Alignment.center,
              //         decoration: BoxDecoration(
              //           color: Colors.grey.shade200,
              //           borderRadius: BorderRadius.circular(14.0),
              //         ),
              //         child: Container(
              //           margin: const EdgeInsets.all(16.0),
              //           padding: const EdgeInsets.all(16.0),
              //           width: double.infinity,
              //           decoration: BoxDecoration(
              //             border: Border.all(
              //               width: 1.8,
              //               color: Colors.grey.shade400,
              //             ),
              //             borderRadius: BorderRadius.circular(14.0),
              //           ),
              //           child: BrowseGalleryButton(
              //             onPress: () {},
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: Strings.pleaseWriteYourMessageHere,
                    labelStyle: TextStyle(color: AppColor.appColor),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.appColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.appColor, width: 2.0),
                    ),
                  ),
                  // autofocus: true,
                  maxLines: null,
                  controller: postController,
                ),
              ),
              const SizedBox(height: 20.0),
              ...PostSetting.values.map(
                (postSetting) => ListTile(
                  title: Text(postSetting.title),
                  subtitle: Text(postSetting.description),
                  trailing: Switch(
                      activeColor: AppColor.appColor,
                      value: postSettings[postSetting] ?? false,
                      onChanged: (isOn) {
                        ref
                            .read(postSettingProvider.notifier)
                            .setSetting(postSetting, isOn);
                      }),
                ),
              ),
              const SizedBox(height: 20.0),
              CommonButton(
                buttonTitle: 'Post',
                onPress: isPostButtonEnabled.value
                    ? () async {
                        final userId = ref.read(userIdProvider);
                        if (userId == null) {
                          return;
                        }
                        final message = postController.text;
                        final isUploaded =
                            await ref.read(imageUploadProvider.notifier).upload(
                                  file: widget.fileToPost,
                                  fileType: widget.fileType,
                                  message: message,
                                  postSettings: postSettings,
                                  userId: userId,
                                );
                        if (isUploaded && mounted) {
                          Navigator.of(context).pop();
                        }
                      }
                    : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}
