import 'package:cinepebble_social/utils/dialogs/alert_dialog_model.dart';
import 'package:cinepebble_social/utils/contants/strings.dart';
import 'package:flutter/foundation.dart';

@immutable
class LoginFailureDialog extends AlertDialogModel<bool> {
  const LoginFailureDialog()
      : super(
          message: '',
          title: 'Invalid Credentials',
          buttons: const {
            Strings.ok: false,
          },
        );
}
