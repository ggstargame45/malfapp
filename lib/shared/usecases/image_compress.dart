import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:malf/shared/logger.dart';

Future<File> compressImage(File file,int quality) async {
  quality-=20;
  logger.i(file.absolute.path);
  logger.i(file.path);
  final int uncompressedSize = file.lengthSync();
  logger.i("uncompressed : ${file.lengthSync()}");
  final result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    "${file.path}compress$quality.jpeg",
    quality: quality,
  );
  logger.i("compressed : ${File(result!.path).lengthSync()}");
  logger.d("quality : $quality,ratio : ${File(result.path).lengthSync()*100/uncompressedSize}");
  return File(result.path);
}