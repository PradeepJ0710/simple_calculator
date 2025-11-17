import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple/core/cubit/update_cubit.dart';
import 'package:simple/core/services/update_service.dart';
import 'package:simple/presentation/screens/update_screen.dart';

import 'core/bloc/calculator_bloc.dart';
import 'core/cubit/theme_cubit.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/calculator_repository.dart';
import 'domain/use_cases/perform_calculation.dart';
import 'presentation/screens/calculator_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock orientation to portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ThemeCubit(),
        ),
        BlocProvider(
          create: (_) => CalculatorBloc(
            performCalculation: PerformCalculation(
              repository: CalculatorRepository(),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => UpdateCubit(AppUpdateService())..checkForUpdates(),
        ),
      ],
      child: BlocBuilder<UpdateCubit, UpdateState>(
        builder: (_, updateState) => BlocBuilder<ThemeCubit, ThemeState>(
          builder: (__, themeState) {
            return MaterialApp(
              title: 'Calculator',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeState.themeMode,
              home: updateState.status == UpdateStatus.available ? const UpdateView() : const CalculatorScreen(),
            );
          },
        ),
      ),
    );
  }
}
