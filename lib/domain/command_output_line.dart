class CommandOutputLine {
  final DateTime timestamp;
  final String text;
  final bool isError;
  final int? exitCode;

  CommandOutputLine({
    required this.timestamp,
    required this.text,
    this.isError = false,
    this.exitCode,
  });
}
