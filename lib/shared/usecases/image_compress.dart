import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:malf/shared/logger.dart';

Future<File> compressImage(File file,int quality) async {
  logger.i(file.absolute.path);
  logger.i(file.path);
  logger.i("uncompressed : ${file.lengthSync()}");
  final result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    "${file.path}compress.jpg",
    quality: quality-20,
  );
  logger.i("compressed : ${File(result!.path).lengthSync()}");
  return File(result.path);
}