import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple/core/bloc/calculator_bloc.dart';
import 'package:simple/core/cubit/theme_cubit.dart';
import 'package:simple/widgets/button_section.dart';
import 'package:simple/widgets/display_section.dart';

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
