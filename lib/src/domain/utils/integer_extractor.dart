int? integerExtractor(dynamic value) {
  if (int.tryParse(value?.toString() ?? '') != null) {
    return int.parse(value.toString());
  }
  return null;
}
