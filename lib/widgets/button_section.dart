import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/bloc/calculator_bloc.dart';
import '../core/constants/app_constants.dart';
import 'calculator_button.dart';

/// Button section containing all calculator buttons
class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CalculatorBloc>();

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Row 1: C, ⌫, %, ÷
          Expanded(
            child: Row(
              children: [
                _buildButton(
                  context,
                  AppConstants.clear,
                  () => bloc.add(const ClearPressed()),
                  ButtonType.function,
                ),
                _buildButton(
                  context,
                  AppConstants.delete,
                  () => bloc.add(const DeletePressed()),
                  ButtonType.function,
                ),
                _buildButton(
                  context,
                  AppConstants.percent,
                  () => bloc.add(const PercentPressed()),
                  ButtonType.operator,
                ),
                _buildButton(
                  context,
                  AppConstants.divide,
                  () => bloc.add(OperationPressed(AppConstants.divide)),
                  ButtonType.operator,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Row 2: 7, 8, 9, ×
          Expanded(
            child: Row(
              children: [
                _buildButton(
                  context,
                  '7',
                  () => bloc.add(const NumberPressed('7')),
                ),
                _buildButton(
                  context,
                  '8',
                  () => bloc.add(const NumberPressed('8')),
                ),
                _buildButton(
                  context,
                  '9',
                  () => bloc.add(const NumberPressed('9')),
                ),
                _buildButton(
                  context,
                  AppConstants.multiply,
                  () => bloc.add(OperationPressed(AppConstants.multiply)),
                  ButtonType.operator,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Row 3: 4, 5, 6, -
          Expanded(
            child: Row(
              children: [
                _buildButton(
                  context,
                  '4',
                  () => bloc.add(const NumberPressed('4')),
                ),
                _buildButton(
                  context,
                  '5',
                  () => bloc.add(const NumberPressed('5')),
                ),
                _buildButton(
                  context,
                  '6',
                  () => bloc.add(const NumberPressed('6')),
                ),
                _buildButton(
                  context,
                  AppConstants.subtract,
                  () => bloc.add(OperationPressed(AppConstants.subtract)),
                  ButtonType.operator,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Row 4: 1, 2, 3, +
          Expanded(
            child: Row(
              children: [
                _buildButton(
                  context,
                  '1',
                  () => bloc.add(const NumberPressed('1')),
                ),
                _buildButton(
                  context,
                  '2',
                  () => bloc.add(const NumberPressed('2')),
                ),
                _buildButton(
                  context,
                  '3',
                  () => bloc.add(const NumberPressed('3')),
                ),
                _buildButton(
                  context,
                  AppConstants.add,
                  () => bloc.add(OperationPressed(AppConstants.add)),
                  ButtonType.operator,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Row 5: +/-, 0, ., =
          Expanded(
            child: Row(
              children: [
                _buildButton(
                  context,
                  AppConstants.plusMinus,
                  () => bloc.add(const PlusMinusPressed()),
                  ButtonType.operator,
                ),
                _buildButton(
                  context,
                  '0',
                  () => bloc.add(const NumberPressed('0')),
                ),
                _buildButton(
                  context,
                  AppConstants.decimal,
                  () => bloc.add(const DecimalPressed()),
                  ButtonType.operator,
                ),
                _buildButton(
                  context,
                  AppConstants.equals,
                  () => bloc.add(const EqualsPressed()),
                  ButtonType.equals,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    BuildContext context,
    String text,
    VoidCallback onPressed, [
    ButtonType type = ButtonType.number,
  ]) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: CalculatorButton(
          text: text,
          onPressed: onPressed,
          type: type,
        ),
      ),
    );
  }
}
