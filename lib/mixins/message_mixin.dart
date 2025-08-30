import 'package:flutter/material.dart';

import '../interfaces/message_service.dart';
import '../services/dialog_message_service.dart';
import '../services/snackbar_message_service.dart';

mixin MessageMixin<T extends StatefulWidget> on State<T> {
  late final MessageService snack;
  late final MessageService dialog;

  @override
  void initState() {
    super.initState();
    snack = SnackbarMessageService();
    dialog = DialogMessageService();
  }
}
