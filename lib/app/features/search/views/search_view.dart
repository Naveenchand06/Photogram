import 'package:cinepebble_social/app/app.dart';
import 'package:cinepebble_social/app/features/search/views/search_grid_view.dart';
import 'package:cinepebble_social/utils/app_colors.dart';
import 'package:cinepebble_social/utils/contants/strings.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchView extends HookConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final searchTerm = useState('');

    useEffect(() {
      controller.addListener(() {
        searchTerm.value = controller.text;
      });
      return () {};
    }, [controller]);

    return SingleChildScrollView(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: controller,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              labelText: Strings.enterYourSearchTermHere,
              labelStyle: TextStyle(color: AppColor.appColor),
              border: const UnderlineInputBorder(
                  borderSide: BorderSide(
                color: AppColor.appColor,
              )),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                color: AppColor.appColor,
              )),
              suffix: IconButton(
                onPressed: () {
                  controller.clear();
                  // dismissKeyboard();
                },
                icon: const Icon(Icons.clear),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SearchGridView(
            searchTerm: searchTerm.value,
          ),
        )
      ],
    ));
  }
}
