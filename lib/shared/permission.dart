import 'package:permission_handler/permission_handler.dart';


Future<bool> cameraPermission() async {
  PermissionStatus status = await Permission.camera.status;
  if(status == PermissionStatus.granted || status == PermissionStatus.limited) return true;
  if(status == PermissionStatus.denied){
    status = await Permission.camera.request();
    if(status == PermissionStatus.granted || status == PermissionStatus.limited) return true;
    return false;
  }
  if(status == PermissionStatus.permanentlyDenied){
    openAppSettings();
  }

  return false;
}


Future<bool> photoPermission() async {
  PermissionStatus status = await Permission.photos.status;  
  if(status == PermissionStatus.granted || status == PermissionStatus.limited) return true;
  if(status == PermissionStatus.denied){
    status = await Permission.photos.request();
    if(status == PermissionStatus.granted || status == PermissionStatus.limited) return true;
    return false;
  }
  if(status == PermissionStatus.permanentlyDenied){
    openAppSettings();
  }
  return false;
}