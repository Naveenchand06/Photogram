import 'package:cinepebble_social/utils/contants/strings.dart';
import 'package:cinepebble_social/utils/dialogs/alert_dialog_model.dart';
import 'package:flutter/foundation.dart';

@immutable
class DeleteDialog extends AlertDialogModel<bool> {
  const DeleteDialog({required String titleOfObjectToDelete})
      : super(
          title: '${Strings.delete} $titleOfObjectToDelete',
          message:
              '${Strings.areYouSureYouWantToDeleteThis} $titleOfObjectToDelete',
          buttons: const {
            Strings.cancel: false,
            Strings.delete: true,
          },
        );
}
