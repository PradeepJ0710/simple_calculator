part of 'calculator_bloc.dart';

/// Base event class for Calculator BLoC
abstract class CalculatorEvent extends Equatable {
  const CalculatorEvent();

  @override
  List<Object?> get props => [];
}

/// Event when a number button is pressed
class NumberPressed extends CalculatorEvent {
  final String number;

  const NumberPressed(this.number);

  @override
  List<Object?> get props => [number];
}

/// Event when an operation button is pressed
class OperationPressed extends CalculatorEvent {
  final String operation;

  const OperationPressed(this.operation);

  @override
  List<Object?> get props => [operation];
}

/// Event when equals button is pressed
class EqualsPressed extends CalculatorEvent {
  const EqualsPressed();
}

/// Event when clear button is pressed
class ClearPressed extends CalculatorEvent {
  const ClearPressed();
}

/// Event when delete button is pressed
class DeletePressed extends CalculatorEvent {
  const DeletePressed();
}

/// Event when decimal button is pressed
class DecimalPressed extends CalculatorEvent {
  const DecimalPressed();
}

/// Event when percent button is pressed
class PercentPressed extends CalculatorEvent {
  const PercentPressed();
}

/// Event when plus/minus button is pressed
class PlusMinusPressed extends CalculatorEvent {
  const PlusMinusPressed();
}

class ToggleHistory extends CalculatorEvent {
  const ToggleHistory();
}

class HistoryItemPressed extends CalculatorEvent {
  final Calculation calculation;

  const HistoryItemPressed(this.calculation);

  @override
  List<Object?> get props => [calculation];
}

class ClearHistory extends CalculatorEvent {
  const ClearHistory();
}
