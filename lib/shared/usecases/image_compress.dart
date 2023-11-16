import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:malf/shared/logger.dart';

Future<File> compressImage(File file, int quality, int many) async {
  final double maxSize = 1024 * 100 * 45 / many;
  logger.i(file.absolute.path);
  logger.i(file.path);
  int fileSize = file.lengthSync();
  logger.i("uncompressed : ${fileSize}");
  if (fileSize < maxSize) {
    return file;
  }
  XFile? result;
  while (fileSize > maxSize) {
    result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      "${file.path}compress$quality.jpeg",
      quality: quality,
    );
    fileSize = File(result!.path).lengthSync();
    logger.i("compressed : ${fileSize}");
    logger.d(
        "quality : $quality,ratio : ${File(result.path).lengthSync() * 100 / fileSize}");
    quality -= 10;
  }
  return File(result!.path);
}
