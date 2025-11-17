part of 'calculator_bloc.dart';

/// State class for Calculator BLoC
class CalculatorState extends Equatable {
  final String displayValue;
  final String expression;
  final double? firstOperand;
  final double? secondOperand;
  final String? operation;
  final bool shouldResetDisplay;
  final bool isError;

  const CalculatorState({
    required this.displayValue,
    required this.expression,
    this.firstOperand,
    this.secondOperand,
    this.operation,
    this.shouldResetDisplay = false,
    this.isError = false,
  });

  factory CalculatorState.initial() {
    return const CalculatorState(
      displayValue: '0',
      expression: '',
      firstOperand: null,
      secondOperand: null,
      operation: null,
      shouldResetDisplay: false,
      isError: false,
    );
  }

  CalculatorState copyWith({
    String? displayValue,
    String? expression,
    double? firstOperand,
    double? secondOperand,
    String? operation,
    bool? shouldResetDisplay,
    bool? isError,
    bool clearOperands = false,
  }) {
    return CalculatorState(
      displayValue: displayValue ?? this.displayValue,
      expression: expression ?? this.expression,
      firstOperand: clearOperands ? null : (firstOperand ?? this.firstOperand),
      secondOperand: clearOperands ? null : (secondOperand ?? this.secondOperand),
      operation: operation ?? this.operation,
      shouldResetDisplay: shouldResetDisplay ?? this.shouldResetDisplay,
      isError: isError ?? this.isError,
    );
  }

  Calculation toCalculation() {
    return Calculation(
      displayValue: displayValue,
      expression: expression,
      result: secondOperand ?? firstOperand,
      operation: operation,
      isError: isError,
    );
  }

  @override
  List<Object?> get props => [
        displayValue,
        expression,
        firstOperand,
        secondOperand,
        operation,
        shouldResetDisplay,
        isError,
      ];
}
