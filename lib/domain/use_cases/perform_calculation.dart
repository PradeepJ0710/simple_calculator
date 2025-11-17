import '../../data/repositories/calculator_repository.dart';

/// Use case for performing calculations
/// Follows Single Responsibility Principle
class PerformCalculation {
  final CalculatorRepository repository;

  PerformCalculation({required this.repository});

  /// Execute calculation
  double? call({
    required double firstOperand,
    required double secondOperand,
    required String operation,
  }) {
    return repository.calculate(
      firstOperand: firstOperand,
      secondOperand: secondOperand,
      operation: operation,
    );
  }

  /// Format number for display
  String formatNumber(double number) {
    return repository.formatNumber(number);
  }

  /// Validate number
  bool isValidNumber(String value) {
    return repository.isValidNumber(value);
  }

  /// Calculate percentage
  double calculatePercentage(double value, double? baseValue) {
    return repository.calculatePercentage(value, baseValue);
  }
}
