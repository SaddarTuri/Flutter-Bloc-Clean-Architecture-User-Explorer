import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_explorer/presentation/bloc/theme/theme_event.dart';
import 'package:user_explorer/presentation/bloc/theme/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(isDarkMode: false)) {
    on<ToggleThemeEvent>(_onToggleTheme);
    on<SetThemeEvent>(_onSetTheme);
  }

  void _onToggleTheme(ToggleThemeEvent event, Emitter<ThemeState> emit) {
    emit(ThemeState(isDarkMode: !state.isDarkMode));
  }

  void _onSetTheme(SetThemeEvent event, Emitter<ThemeState> emit) {
    emit(ThemeState(isDarkMode: event.isDarkMode));
  }
}
