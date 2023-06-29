import 'package:king_investor_wallet/src/domain/exceptions/validation_exception.dart';
import 'package:result_dart/result_dart.dart';

abstract class ValueObject<T> {
  final T value;

  const ValueObject(this.value);

  bool get isValid => validate() is Success;

  String? get errorMessage => validate().exceptionOrNull()?.toString();

  Result<ValueObject<T>, ValidationException> validate();

  @override
  bool operator ==(covariant ValueObject<T> other) {
    if (identical(this, other)) return true;
    return other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => '$runtimeType: $value';
}
