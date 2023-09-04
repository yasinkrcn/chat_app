extension StringNullableExtension on String? {
  String get getValueOrDefault => this ?? "";
}
