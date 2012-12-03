part of scaleapp;

class NoPermissionException implements Exception {
  final String msg;
  const NoPermissionException([this.msg]);
  String toString() => msg == null ? 'NoPermissionException' : msg;
}

class NotAvailableException implements Exception {
  final String msg;
  const NotAvailableException([this.msg]);
  String toString() => msg == null ? 'NotAvailableException' : msg;
}
