import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart' as pathPrivider;

Future<String> get localPath async {
  final dir = await pathPrivider.getApplicationDocumentsDirectory();
  return dir.path;
}

Future<File> localFile(String filename) async {
  final path = await localPath;
  return File('$path/' + filename);
}

Future<String> readData(String filename) async {
  try {
    final file = await localFile(filename);
    String body = await file.readAsString();
    return body;
  } catch (e) {
    print('writeData.dart readData(String filename) function error: ' +
        e.toString());
    return '';
  }
}

Future<File> writeData(String filename, String data) async {
  final file = await localFile(filename);
  return file.writeAsString("$data");
}
