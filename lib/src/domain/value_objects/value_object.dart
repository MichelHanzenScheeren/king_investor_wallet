import 'package:multiple_result/multiple_result.dart';

abstract class ValueObject<T> {
  final T value;

  const ValueObject(this.value);

  bool get isValid => validate() is Success;

  Result<ValueObject<T>, String> validate();

  @override
  bool operator ==(covariant ValueObject<T> other) {
    if (identical(this, other)) return true;
    return other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
