import '../../core/constants/app_constants.dart';

/// Repository responsible for calculation logic
class CalculatorRepository {
  /// Performs mathematical calculation based on operation
  double? calculate({
    required double firstOperand,
    required double secondOperand,
    required String operation,
  }) {
    try {
      switch (operation) {
        case AppConstants.add:
          return firstOperand + secondOperand;
        case AppConstants.subtract:
          return firstOperand - secondOperand;
        case AppConstants.multiply:
          return firstOperand * secondOperand;
        case AppConstants.divide:
          if (secondOperand == 0) {
            throw Exception(AppConstants.divideByZeroError);
          }
          return firstOperand / secondOperand;
        default:
          return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Formats number for display
  String formatNumber(double number) {
    // Remove trailing zeros and unnecessary decimal point
    String formatted = number.toString();
    if (formatted.contains('.')) {
      formatted = formatted.replaceAll(RegExp(r'0*$'), '');
      formatted = formatted.replaceAll(RegExp(r'\.$'), '');
    }

    // Limit to max digits
    if (formatted.length > AppConstants.maxDigits) {
      // Use scientific notation for very large numbers
      if (number.abs() >= 1e10 || number.abs() < 1e-6) {
        return number.toStringAsExponential(6);
      }
      formatted = number.toStringAsFixed(
        AppConstants.maxDigits - formatted.indexOf('.') - 1,
      );
    }

    return formatted;
  }

  /// Validates if string is a valid number
  bool isValidNumber(String value) {
    if (value.isEmpty || value == AppConstants.initialDisplay) {
      return false;
    }
    return double.tryParse(value) != null;
  }

  /// Calculates percentage
  double calculatePercentage(double value, double? baseValue) {
    if (baseValue != null) {
      return baseValue * (value / 100);
    }
    return value / 100;
  }
}
