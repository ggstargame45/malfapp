import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:malf/shared/theme/app_colors.dart';

void loading(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return LoadingAnimationWidget.inkDrop(
          color: AppColors.primary,
          size: 100,
        );
      });
}
