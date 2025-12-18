import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple/core/bloc/calculator_bloc.dart';
import 'package:simple/core/cubit/theme_cubit.dart';
import 'package:simple/widgets/button_section.dart';
import 'package:simple/widgets/display_section.dart';
import 'package:simple/widgets/history_section.dart';

/// Main calculator screen with update handling
class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          // History toggle
          BlocBuilder<CalculatorBloc, CalculatorState>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(
                  state.isHistoryVisible
                      ? Icons.history_toggle_off
                      : Icons.history,
                ),
                onPressed: () {
                  if (state.history.isNotEmpty) {
                    context.read<CalculatorBloc>().add(const ToggleHistory());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(milliseconds: 1250),
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          'No history to show',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  }
                },
                tooltip: 'History',
              );
            },
          ),
          // Theme toggle
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return IconButton(
                icon: Icon(_getThemeIcon(themeState.themeMode)),
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
                tooltip: _getThemeTooltip(themeState.themeMode),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // History Section (Collapsible)
            BlocBuilder<CalculatorBloc, CalculatorState>(
              buildWhen: (previous, current) =>
                  previous.isHistoryVisible != current.isHistoryVisible,
              builder: (context, state) {
                return AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: SizedBox(
                    // Limit height to 35% of screen height roughly, or fixed height
                    height: state.isHistoryVisible
                        ? MediaQuery.sizeOf(context).height * 0.35
                        : 0,
                    child: state.isHistoryVisible
                        ? const HistorySection()
                        : const SizedBox.shrink(),
                  ),
                );
              },
            ),
            // Display section (takes 35% of screen)
            Expanded(
              flex: 35,
              child: BlocBuilder<CalculatorBloc, CalculatorState>(
                builder: (_, state) {
                  return DisplaySection(
                    expression: state.expression,
                    displayValue: state.displayValue,
                    isError: state.isError,
                  );
                },
              ),
            ),

            // Button section (takes 65% of screen)
            const Expanded(
              flex: 65,
              child: ButtonSection(),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getThemeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.brightness_auto;
    }
  }

  String _getThemeTooltip(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light Mode';
      case ThemeMode.dark:
        return 'Dark Mode';
      case ThemeMode.system:
        return 'System Theme';
    }
  }
}
