class CmsDelegateException implements Exception {
  final String message;

  const CmsDelegateException(this.message);

  @override
  String toString() => message;
}
