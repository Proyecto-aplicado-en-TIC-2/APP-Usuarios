import 'package:appv2/main.dart';
import 'package:flutter/material.dart';

@immutable
class BasilTheme extends ThemeExtension<BasilTheme> {
  const BasilTheme({
    this.surfaceContainer = const Color(4294699755),
    this.surface = const Color(4294965495),
    this.onSurface = const Color(4280424730),
    this.onSurfaceVariant = const Color(4283581252),
    this.primaryContainer = const Color(4294957533),
    this.primary = const Color(4287514964),
    this.secondary = const Color(4285945434),
    this.custom = const Color(4286140289),
  });

  final Color surfaceContainer;
  final Color surface;
  final Color onSurface;
  final Color onSurfaceVariant;
  final Color primaryContainer;
  final Color primary;
  final Color secondary;
  final Color custom;

  @override
  BasilTheme copyWith({
    Color? surfaceContainer,
    Color? surface,
    Color? onSurface,
    Color? onSurfaceVariant,
    Color? primaryContainer,
    Color? primary,
    Color? secondary,
    Color? custom,
  }) {
    return BasilTheme(
      surfaceContainer: surfaceContainer ?? this.surfaceContainer,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      custom: custom ?? this.custom,
    );
  }

  @override
  BasilTheme lerp(covariant ThemeExtension<BasilTheme>? other, double t) {
    if (other is! BasilTheme) return this;

    return BasilTheme(
      surfaceContainer: Color.lerp(surfaceContainer, other.surfaceContainer, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      onSurfaceVariant: Color.lerp(onSurfaceVariant, other.onSurfaceVariant, t)!,
      primaryContainer: Color.lerp(primaryContainer, other.primaryContainer, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      custom: Color.lerp(custom, other.custom, t)!,
    );
  }

  ThemeData toThemeData() {
    return ThemeData(
      useMaterial3: true,
      extensions: [this], // Agrega BasilTheme como extensión de tema
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: Colors.white,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onSurface,
        secondary: secondary,
        onSecondary: Colors.white,
        secondaryContainer: surfaceContainer,
        onSecondaryContainer: onSurface,
        surface: surface,
        onSurface: onSurface,
        error: Colors.red,
        onError: Colors.white,
        outline: onSurfaceVariant,
        onSurfaceVariant: onSurfaceVariant,
        shadow: Colors.black,
        scrim: Colors.black,
        inverseSurface: onSurface,
        inversePrimary: primary,
      ),
    );
  }
}

class BasilApp extends StatelessWidget {
  const BasilApp({super.key});

  @override
  Widget build(BuildContext context) {
    const basilTheme = BasilTheme();

    return MaterialApp(
      title: 'Gestion de riesgos UPB',
      theme: basilTheme.toThemeData(),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}