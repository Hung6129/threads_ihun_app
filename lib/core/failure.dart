class Failure {
  final String message;
  final StackTrace stackTrace;

  const Failure(this.stackTrace, this.message);
}
