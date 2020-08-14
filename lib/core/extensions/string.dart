extension StringX on String {
  String capitalize() {
    return length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : this;
  }

  double parseDouble([double defaultValue = 0.0]) {
    return double.tryParse(replaceAll((r'[^0-9\.]'), '')) ?? defaultValue;
  }
}
