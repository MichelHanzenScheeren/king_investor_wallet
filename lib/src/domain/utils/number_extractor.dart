double? numberExtractor(dynamic value) {
  if (double.tryParse(value?.toString() ?? '') != null) {
    return double.parse(value.toString());
  }
  return null;
}
