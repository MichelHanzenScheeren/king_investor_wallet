abstract class AppException implements Exception {
  final String? code;
  final String message;

  AppException({
    this.code,
    required this.message,
  });

  @override
  String toString() {
    return message;
  }

  String completeLog() {
    return 'code ${code ?? "unknown"}: $message';
  }
}
