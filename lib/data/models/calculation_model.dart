import '../../domain/entities/calculation.dart';

/// Model for handling calculation data in the data layer
class CalculationModel extends Calculation {
  const CalculationModel({
    required super.displayValue,
    required super.expression,
    super.result,
    super.operation,
    super.isError,
  });

  factory CalculationModel.fromEntity(Calculation calculation) {
    return CalculationModel(
      displayValue: calculation.displayValue,
      expression: calculation.expression,
      result: calculation.result,
      operation: calculation.operation,
      isError: calculation.isError,
    );
  }

  Calculation toEntity() {
    return Calculation(
      displayValue: displayValue,
      expression: expression,
      result: result,
      operation: operation,
      isError: isError,
    );
  }

  @override
  CalculationModel copyWith({
    String? displayValue,
    String? expression,
    double? result,
    String? operation,
    bool? isError,
  }) {
    return CalculationModel(
      displayValue: displayValue ?? this.displayValue,
      expression: expression ?? this.expression,
      result: result ?? this.result,
      operation: operation ?? this.operation,
      isError: isError ?? this.isError,
    );
  }
}
