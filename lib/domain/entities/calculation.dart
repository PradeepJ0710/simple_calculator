import 'package:equatable/equatable.dart';

/// Entity representing a calculation in the domain layer
class Calculation extends Equatable {
  final String displayValue;
  final String expression;
  final double? result;
  final String? operation;
  final bool isError;

  const Calculation({
    required this.displayValue,
    required this.expression,
    this.result,
    this.operation,
    this.isError = false,
  });

  factory Calculation.initial() {
    return const Calculation(
      displayValue: '0',
      expression: '',
      result: null,
      operation: null,
      isError: false,
    );
  }

  Calculation copyWith({
    String? displayValue,
    String? expression,
    double? result,
    String? operation,
    bool? isError,
  }) {
    return Calculation(
      displayValue: displayValue ?? this.displayValue,
      expression: expression ?? this.expression,
      result: result ?? this.result,
      operation: operation ?? this.operation,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object?> get props => [
        displayValue,
        expression,
        result,
        operation,
        isError,
      ];
}
