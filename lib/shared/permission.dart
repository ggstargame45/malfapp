import 'dart:io';

import 'package:malf/shared/logger.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> cameraPermission() async {
  PermissionStatus status = await Permission.camera.status;
  if (status == PermissionStatus.granted || status == PermissionStatus.limited)
    return true;
  if (status == PermissionStatus.denied) {
    status = await Permission.camera.request();
    if (status == PermissionStatus.granted ||
        status == PermissionStatus.limited) return true;
    return false;
  }
  if (status == PermissionStatus.permanentlyDenied) {
    openAppSettings();
  }

  return false;
}

Future<bool> photoPermission() async {
  logger.d("photoPermission");
  PermissionStatus status = await Permission.photos.status;
  logger.d("status : $status");
  logger.d("photoPermissionaaaa");
  if (status == PermissionStatus.granted || status == PermissionStatus.limited) {
    return true;
  }
  logger.d("photoPermissionaaaa");
  if (status == PermissionStatus.denied) {
    status = await Permission.photos.request();
    if (status == PermissionStatus.granted ||
        status == PermissionStatus.limited) {
      return true;
    }
  }
  if (status == PermissionStatus.permanentlyDenied) {
    openAppSettings();
  }
  if (Platform.isAndroid) {
    status = await Permission.storage.status;
    if (status == PermissionStatus.denied) {
      status = await Permission.storage.request();
      if (status == PermissionStatus.granted ||
          status == PermissionStatus.limited) return true;
      return false;
    }
    if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }
  return false;
}
