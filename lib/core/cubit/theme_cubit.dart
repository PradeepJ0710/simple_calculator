import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit for managing theme mode
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(ThemeMode.system));

  void toggleTheme() {
    final newMode = state.themeMode == ThemeMode.light
        ? ThemeMode.dark
        : state.themeMode == ThemeMode.dark
            ? ThemeMode.system
            : ThemeMode.light;
    emit(ThemeState(newMode));
  }

  // void setThemeMode(ThemeMode mode) {
  //   emit(ThemeState(mode));
  // }
}

/// State for theme
class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}
