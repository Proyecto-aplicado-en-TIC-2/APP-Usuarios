import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);
  static MaterialScheme lightScheme() {

    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4287514964),
      surfaceTint: Color(4287514964),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4294957533),
      onPrimaryContainer: Color(4282058516),
      secondary: Color(4285945434),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4294957533),
      onSecondaryContainer: Color(4281079064),
      tertiary: Color(4286076977),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4294958520),
      onTertiaryContainer: Color(4280948480),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      background: Color(4294965495),
      onBackground: Color(4280424730),
      surface: Color(4294965495),
      onSurface: Color(4280424730),
      surfaceVariant: Color(4294237663),
      onSurfaceVariant: Color(4283581252),
      outline: Color(4286870388),
      outlineVariant: Color(4292329923),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281871919),
      inverseOnSurface: Color(4294897133),
      inversePrimary: Color(4294947516),
      primaryFixed: Color(4294957533),
      onPrimaryFixed: Color(4282058516),
      primaryFixedDim: Color(4294947516),
      onPrimaryFixedVariant: Color(4285674302),
      secondaryFixed: Color(4294957533),
      onSecondaryFixed: Color(4281079064),
      secondaryFixedDim: Color(4293246401),
      onSecondaryFixedVariant: Color(4284235587),
      tertiaryFixed: Color(4294958520),
      onTertiaryFixed: Color(4280948480),
      tertiaryFixedDim: Color(4293574543),
      onTertiaryFixedVariant: Color(4284367132),
      surfaceDim: Color(4293383895),
      surfaceBright: Color(4294965495),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294963441),
      surfaceContainer: Color(4294699755),
      surfaceContainerHigh: Color(4294370533),
      surfaceContainerHighest: Color(4293975775),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4285345594),
      surfaceTint: Color(4287514964),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4289290090),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4283972415),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4287523952),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4284103960),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4287721029),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      background: Color(4294965495),
      onBackground: Color(4280424730),
      surface: Color(4294965495),
      onSurface: Color(4280424730),
      surfaceVariant: Color(4294237663),
      onSurfaceVariant: Color(4283318081),
      outline: Color(4285225820),
      outlineVariant: Color(4287133304),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281871919),
      inverseOnSurface: Color(4294897133),
      inversePrimary: Color(4294947516),
      primaryFixed: Color(4289290090),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4287317842),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4287523952),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4285748311),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4287721029),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4285945391),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4293383895),
      surfaceBright: Color(4294965495),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294963441),
      surfaceContainer: Color(4294699755),
      surfaceContainerHigh: Color(4294370533),
      surfaceContainerHighest: Color(4293975775),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4282650138),
      surfaceTint: Color(4287514964),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4285345594),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4281539359),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4283972415),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4281605376),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4284103960),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      background: Color(4294965495),
      onBackground: Color(4280424730),
      surface: Color(4294965495),
      onSurface: Color(4278190080),
      surfaceVariant: Color(4294237663),
      onSurfaceVariant: Color(4281147682),
      outline: Color(4283318081),
      outlineVariant: Color(4283318081),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281871919),
      inverseOnSurface: Color(4294967295),
      inversePrimary: Color(4294960872),
      primaryFixed: Color(4285345594),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4283504932),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4283972415),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4282328617),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4284103960),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4282394372),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4293383895),
      surfaceBright: Color(4294965495),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294963441),
      surfaceContainer: Color(4294699755),
      surfaceContainerHigh: Color(4294370533),
      surfaceContainerHighest: Color(4293975775),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294947516),
      surfaceTint: Color(4294947516),
      onPrimary: Color(4283833640),
      primaryContainer: Color(4285674302),
      onPrimaryContainer: Color(4294957533),
      secondary: Color(4293246401),
      onSecondary: Color(4282591533),
      secondaryContainer: Color(4284235587),
      onSecondaryContainer: Color(4294957533),
      tertiary: Color(4293574543),
      onTertiary: Color(4282723079),
      tertiaryContainer: Color(4284367132),
      onTertiaryContainer: Color(4294958520),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      background: Color(4279898386),
      onBackground: Color(4293975775),
      surface: Color(4279898386),
      onSurface: Color(4293975775),
      surfaceVariant: Color(4283581252),
      onSurfaceVariant: Color(4292329923),
      outline: Color(4288646286),
      outlineVariant: Color(4283581252),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293975775),
      inverseOnSurface: Color(4281871919),
      inversePrimary: Color(4287514964),
      primaryFixed: Color(4294957533),
      onPrimaryFixed: Color(4282058516),
      primaryFixedDim: Color(4294947516),
      onPrimaryFixedVariant: Color(4285674302),
      secondaryFixed: Color(4294957533),
      onSecondaryFixed: Color(4281079064),
      secondaryFixedDim: Color(4293246401),
      onSecondaryFixedVariant: Color(4284235587),
      tertiaryFixed: Color(4294958520),
      onTertiaryFixed: Color(4280948480),
      tertiaryFixedDim: Color(4293574543),
      onTertiaryFixedVariant: Color(4284367132),
      surfaceDim: Color(4279898386),
      surfaceBright: Color(4282464055),
      surfaceContainerLowest: Color(4279503885),
      surfaceContainerLow: Color(4280424730),
      surfaceContainer: Color(4280687902),
      surfaceContainerHigh: Color(4281411624),
      surfaceContainerHighest: Color(4282200627),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294949057),
      surfaceTint: Color(4294947516),
      onPrimary: Color(4281533199),
      primaryContainer: Color(4291394181),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4293509573),
      onSecondary: Color(4280684563),
      secondaryContainer: Color(4289497227),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4293837715),
      onTertiary: Color(4280488704),
      tertiaryContainer: Color(4289759838),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      background: Color(4279898386),
      onBackground: Color(4293975775),
      surface: Color(4279898386),
      onSurface: Color(4294965753),
      surfaceVariant: Color(4283581252),
      onSurfaceVariant: Color(4292593351),
      outline: Color(4289896096),
      outlineVariant: Color(4287725440),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293975775),
      inverseOnSurface: Color(4281411624),
      inversePrimary: Color(4285740095),
      primaryFixed: Color(4294957533),
      onPrimaryFixed: Color(4281073674),
      primaryFixedDim: Color(4294947516),
      onPrimaryFixedVariant: Color(4284293678),
      secondaryFixed: Color(4294957533),
      onSecondaryFixed: Color(4280290062),
      secondaryFixedDim: Color(4293246401),
      onSecondaryFixedVariant: Color(4283051826),
      tertiaryFixed: Color(4294958520),
      onTertiaryFixed: Color(4280028672),
      tertiaryFixedDim: Color(4293574543),
      onTertiaryFixedVariant: Color(4283117836),
      surfaceDim: Color(4279898386),
      surfaceBright: Color(4282464055),
      surfaceContainerLowest: Color(4279503885),
      surfaceContainerLow: Color(4280424730),
      surfaceContainer: Color(4280687902),
      surfaceContainerHigh: Color(4281411624),
      surfaceContainerHighest: Color(4282200627),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294965753),
      surfaceTint: Color(4294947516),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4294949057),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294965753),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4293509573),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294966007),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4293837715),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      background: Color(4279898386),
      onBackground: Color(4293975775),
      surface: Color(4279898386),
      onSurface: Color(4294967295),
      surfaceVariant: Color(4283581252),
      onSurfaceVariant: Color(4294965753),
      outline: Color(4292593351),
      outlineVariant: Color(4292593351),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293975775),
      inverseOnSurface: Color(4278190080),
      inversePrimary: Color(4283307554),
      primaryFixed: Color(4294959074),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4294949057),
      onPrimaryFixedVariant: Color(4281533199),
      secondaryFixed: Color(4294959074),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4293509573),
      onSecondaryFixedVariant: Color(4280684563),
      tertiaryFixed: Color(4294959812),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4293837715),
      onTertiaryFixedVariant: Color(4280488704),
      surfaceDim: Color(4279898386),
      surfaceBright: Color(4282464055),
      surfaceContainerLowest: Color(4279503885),
      surfaceContainerLow: Color(4280424730),
      surfaceContainer: Color(4280687902),
      surfaceContainerHigh: Color(4281411624),
      surfaceContainerHighest: Color(4282200627),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );

  /// Custom Color 1
  static const customColor1 = ExtendedColor(
    seed: Color(4290194906),
    value: Color(4290194906),
    light: ColorFamily(
      color: Color(4286140289),
      onColor: Color(4294967295),
      colorContainer: Color(4294825727),
      onColorContainer: Color(4281338425),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(4286140289),
      onColor: Color(4294967295),
      colorContainer: Color(4294825727),
      onColorContainer: Color(4281338425),
    ),
    lightHighContrast: ColorFamily(
      color: Color(4286140289),
      onColor: Color(4294967295),
      colorContainer: Color(4294825727),
      onColorContainer: Color(4281338425),
    ),
    dark: ColorFamily(
      color: Color(4293506543),
      onColor: Color(4282851664),
      colorContainer: Color(4284495720),
      onColorContainer: Color(4294825727),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(4293506543),
      onColor: Color(4282851664),
      colorContainer: Color(4284495720),
      onColorContainer: Color(4294825727),
    ),
    darkHighContrast: ColorFamily(
      color: Color(4293506543),
      onColor: Color(4282851664),
      colorContainer: Color(4284495720),
      onColorContainer: Color(4294825727),
    ),
  );


  List<ExtendedColor> get extendedColors => [
    customColor1,
  ];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary, 
    required this.surfaceTint, 
    required this.onPrimary, 
    required this.primaryContainer, 
    required this.onPrimaryContainer, 
    required this.secondary, 
    required this.onSecondary, 
    required this.secondaryContainer, 
    required this.onSecondaryContainer, 
    required this.tertiary, 
    required this.onTertiary, 
    required this.tertiaryContainer, 
    required this.onTertiaryContainer, 
    required this.error, 
    required this.onError, 
    required this.errorContainer, 
    required this.onErrorContainer, 
    required this.background, 
    required this.onBackground, 
    required this.surface, 
    required this.onSurface, 
    required this.surfaceVariant, 
    required this.onSurfaceVariant, 
    required this.outline, 
    required this.outlineVariant, 
    required this.shadow, 
    required this.scrim, 
    required this.inverseSurface, 
    required this.inverseOnSurface, 
    required this.inversePrimary, 
    required this.primaryFixed, 
    required this.onPrimaryFixed, 
    required this.primaryFixedDim, 
    required this.onPrimaryFixedVariant, 
    required this.secondaryFixed, 
    required this.onSecondaryFixed, 
    required this.secondaryFixedDim, 
    required this.onSecondaryFixedVariant, 
    required this.tertiaryFixed, 
    required this.onTertiaryFixed, 
    required this.tertiaryFixedDim, 
    required this.onTertiaryFixedVariant, 
    required this.surfaceDim, 
    required this.surfaceBright, 
    required this.surfaceContainerLowest, 
    required this.surfaceContainerLow, 
    required this.surfaceContainer, 
    required this.surfaceContainerHigh, 
    required this.surfaceContainerHighest, 
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
