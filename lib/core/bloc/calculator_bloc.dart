import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/app_constants.dart';
import '../../domain/entities/calculation.dart';
import '../../domain/use_cases/perform_calculation.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

/// BLoC for managing calculator state and business logic
class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  final PerformCalculation performCalculation;

  CalculatorBloc({required this.performCalculation}) : super(CalculatorState.initial()) {
    on<NumberPressed>(_onNumberPressed);
    on<OperationPressed>(_onOperationPressed);
    on<EqualsPressed>(_onEqualsPressed);
    on<ClearPressed>(_onClearPressed);
    on<DeletePressed>(_onDeletePressed);
    on<DecimalPressed>(_onDecimalPressed);
    on<PercentPressed>(_onPercentPressed);
    on<PlusMinusPressed>(_onPlusMinusPressed);
  }

  void _onNumberPressed(NumberPressed event, Emitter<CalculatorState> emit) {
    if (state.isError) {
      emit(CalculatorState.initial());
      return;
    }

    String newDisplay;
    if (state.shouldResetDisplay || state.displayValue == '0') {
      newDisplay = event.number;
    } else {
      if (state.displayValue.length >= AppConstants.maxDigits) return;
      newDisplay = state.displayValue + event.number;
    }

    emit(state.copyWith(
      displayValue: newDisplay,
      shouldResetDisplay: false,
    ));
  }

  void _onOperationPressed(OperationPressed event, Emitter<CalculatorState> emit) {
    if (state.isError) {
      emit(CalculatorState.initial());
      return;
    }

    final currentValue = double.tryParse(state.displayValue);
    if (currentValue == null) return;

    // If there's already an operation and operands, calculate first
    if (state.firstOperand != null && state.operation != null && !state.shouldResetDisplay) {
      try {
        final result = performCalculation(
          firstOperand: state.firstOperand!,
          secondOperand: currentValue,
          operation: state.operation!,
        );

        if (result != null) {
          final formattedResult = performCalculation.formatNumber(result);
          emit(state.copyWith(
            displayValue: formattedResult,
            expression: '$formattedResult ${event.operation}',
            firstOperand: result,
            operation: event.operation,
            shouldResetDisplay: true,
          ));
        }
      } catch (e) {
        emit(state.copyWith(
          displayValue: AppConstants.errorMessage,
          expression: '',
          isError: true,
          clearOperands: true,
        ));
      }
    } else {
      emit(state.copyWith(
        firstOperand: currentValue,
        operation: event.operation,
        expression: '${state.displayValue} ${event.operation}',
        shouldResetDisplay: true,
      ));
    }
  }

  void _onEqualsPressed(EqualsPressed event, Emitter<CalculatorState> emit) {
    if (state.isError) {
      emit(CalculatorState.initial());
      return;
    }

    if (state.firstOperand == null || state.operation == null) return;

    final currentValue = double.tryParse(state.displayValue);
    if (currentValue == null) return;

    try {
      final result = performCalculation(
        firstOperand: state.firstOperand!,
        secondOperand: currentValue,
        operation: state.operation!,
      );

      if (result != null) {
        final formattedResult = performCalculation.formatNumber(result);
        emit(state.copyWith(
          displayValue: formattedResult,
          expression: '${state.expression} ${state.displayValue} =',
          secondOperand: result,
          shouldResetDisplay: true,
          clearOperands: true,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        displayValue: AppConstants.errorMessage,
        expression: e.toString().contains('zero') ? AppConstants.divideByZeroError : AppConstants.errorMessage,
        isError: true,
        clearOperands: true,
      ));
    }
  }

  void _onClearPressed(ClearPressed event, Emitter<CalculatorState> emit) {
    emit(CalculatorState.initial());
  }

  void _onDeletePressed(DeletePressed event, Emitter<CalculatorState> emit) {
    if (state.isError) {
      emit(CalculatorState.initial());
      return;
    }

    if (state.displayValue.length == 1 || state.displayValue == '0') {
      emit(state.copyWith(displayValue: '0'));
    } else {
      emit(state.copyWith(
        displayValue: state.displayValue.substring(0, state.displayValue.length - 1),
      ));
    }
  }

  void _onDecimalPressed(DecimalPressed event, Emitter<CalculatorState> emit) {
    if (state.isError) {
      emit(CalculatorState.initial());
      return;
    }

    if (state.shouldResetDisplay) {
      emit(state.copyWith(
        displayValue: '0.',
        shouldResetDisplay: false,
      ));
    } else if (!state.displayValue.contains('.')) {
      emit(state.copyWith(
        displayValue: '${state.displayValue}.',
      ));
    }
  }

  void _onPercentPressed(PercentPressed event, Emitter<CalculatorState> emit) {
    if (state.isError) {
      emit(CalculatorState.initial());
      return;
    }

    final currentValue = double.tryParse(state.displayValue);
    if (currentValue == null) return;

    final percentValue = performCalculation.calculatePercentage(
      currentValue,
      state.firstOperand,
    );
    final formattedValue = performCalculation.formatNumber(percentValue);

    emit(state.copyWith(
      displayValue: formattedValue,
      shouldResetDisplay: true,
    ));
  }

  void _onPlusMinusPressed(PlusMinusPressed event, Emitter<CalculatorState> emit) {
    if (state.isError) {
      emit(CalculatorState.initial());
      return;
    }

    final currentValue = double.tryParse(state.displayValue);
    if (currentValue == null || currentValue == 0) return;

    final newValue = currentValue * -1;
    final formattedValue = performCalculation.formatNumber(newValue);

    emit(state.copyWith(displayValue: formattedValue));
  }
}
