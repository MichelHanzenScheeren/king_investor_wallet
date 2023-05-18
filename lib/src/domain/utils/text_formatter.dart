String textFormatter(String value) {
  final values = value.toLowerCase().split(' ');
  values.removeWhere((item) => item == '');
  return values
      .map((e) => e.length > 2 ? (e[0].toUpperCase() + e.substring(1)) : e)
      .join(' ');
}
