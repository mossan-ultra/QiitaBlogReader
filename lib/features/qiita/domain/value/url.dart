import 'package:flutter/cupertino.dart';

@immutable
class URL {
  late final Uri value;

  URL({required String value}) {
    if (value.isEmpty) {
      throw Exception('value is not empty');
    }
    try {
      this.value = Uri.parse(value);
    } on Exception catch (e) {
      throw Exception('url parse error : $e');
    }
  }
  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is URL && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
