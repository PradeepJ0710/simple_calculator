import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple/core/bloc/calculator_bloc.dart';
import 'package:simple/domain/entities/calculation.dart';

class HistorySection extends StatelessWidget {
  const HistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorBloc, CalculatorState>(
      builder: (context, state) {
        if (state.history.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              state.history.isNotEmpty
                  ? TextButton(
                      onPressed: () {
                        context.read<CalculatorBloc>().add(ClearHistory());
                      },
                      child: const Text(
                        'Clear History',
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    )
                  : const SizedBox.shrink(),
              Expanded(
                child: ListView.separated(
                  reverse: true,
                  padding: EdgeInsets.zero,
                  itemCount: state.history.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final calculation = state.history[index];
                    return _HistoryItem(calculation: calculation);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final Calculation calculation;

  const _HistoryItem({required this.calculation});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () {
        context.read<CalculatorBloc>().add(HistoryItemPressed(calculation));
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              calculation.expression,
              style: TextStyle(
                fontWeight: FontWeight.w100,
                fontSize: 18,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              calculation.result.toString(),
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
