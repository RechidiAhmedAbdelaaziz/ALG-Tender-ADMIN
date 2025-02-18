import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender_admin/core/extension/navigator.extension.dart';

import '../themes/colors.dart';

extension DialogExtension on BuildContext {
  /// Show a dialog with the given [child] widget.
  /// [T] is the type of the result that will be returned when the dialog is closed.
  Future<T?> dialog<T>({
    required Widget child,
  }) {
    return showDialog<T>(
      context: this,
      builder: (_) => Stack(
        alignment: Alignment.center,
        children: [
          Material(
            color: Colors.transparent,
            child: child,
          ),
        ],
      ),
    );
  }

  /// Show a dialog with the given [child] widget.
  /// [T] is the type of the result that will be returned when the dialog is closed.
  /// [onResult] is called when the dialog is closed with a result.
  /// [onError] is called when the dialog is closed without a result.
  Future<void> dialogWith<T>({
    required Widget child,
    required void Function(T) onResult,
    VoidCallback? onError,
    bool autoBack = true,
  }) async {
    final result = await dialog<T>(child: child);
    result != null ? onResult(result) : onError?.call();
    if (autoBack) back();
  }

  /// Show a alert dialog with the given [title] and [content].
  /// [onConfirm] is called when the user press the ok button.
  /// [onCancel] is called when the user press the cancel button.
  /// [okText] is the text of the ok button.
  /// [cancelText] is the text of the cancel button.
  Future<void> alertDialog({
    required String title,
    required String? content,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    String okText = 'Ok',
    String cancelText = 'Cancel',
  }) async {
    return showDialog(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: content != null ? Text(content) : null,
        actions: [
          _buildButton(
            text: cancelText,
            onPressed: () {
              onCancel?.call();
              context.back();
            },
            color: Colors.white,
            borderColor: KColors.primary,
            textColor: Colors.blue,
          ),
          _buildButton(
            text: okText,
            onPressed: () {
              onConfirm();
              context.back();
            },
            color: Colors.blue,
            borderColor: Colors.white,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required VoidCallback onPressed,
    required Color color,
    required Color borderColor,
    required Color textColor,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(color),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
            side: BorderSide(color: borderColor),
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
