extension StringExt on String {
  String get capitalize =>
      (isNotEmpty) ? this[0].toUpperCase() + substring(1) : this;
}
