import 'package:equatable/equatable.dart';

class ThemeState extends Equatable {
  const ThemeState({required this.isDarkMode});

  final bool isDarkMode;

  @override
  List<Object?> get props => [isDarkMode];
}
