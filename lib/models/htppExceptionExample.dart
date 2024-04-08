// ignore_for_file: file_names

class HttpException2 implements Exception {
  final String message;
  HttpException2(this.message);

  @override
  String toString() {
    return message;
  }
}
