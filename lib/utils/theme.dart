import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/utils/colors.dart';

final ThemeData theme = ThemeData(
  fontFamily: GoogleFonts.jost().fontFamily,
  textTheme: textTheme,
);

final TextTheme textTheme = TextTheme(
  displayLarge: GoogleFonts.jost(
    fontSize: 160,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  ),
  displayMedium: GoogleFonts.jost(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  ),
  displaySmall: GoogleFonts.jost(
    fontSize: 35,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  ),
  titleLarge: GoogleFonts.jost(
    fontSize: 25,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  ),
  titleMedium: GoogleFonts.jost(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  ),
  titleSmall: GoogleFonts.jost(
    color: AppColors.black,
    fontWeight: FontWeight.w600,
    fontSize: 22,
  ),
  bodyLarge: GoogleFonts.jost(
    fontSize: 22,
    height: 1.25,
    color: AppColors.black,
  ),
  bodyMedium: GoogleFonts.jost(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  ),
  bodySmall: GoogleFonts.jost(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  ),
  labelLarge: GoogleFonts.jost(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  ),
  labelMedium: GoogleFonts.jost(
    fontSize: 18,
    color: AppColors.black,
  ),
  labelSmall: GoogleFonts.jost(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: AppColors.textGray,
      letterSpacing: 0),
);

final TextStyle appBarTitleTextStyle = GoogleFonts.jost(
  fontSize: 20,
  fontWeight: FontWeight.w600,
);

final BoxDecoration tileBoxDecoration = BoxDecoration(
  border: Border(bottom: BorderSide(color: AppColors.dividerGray)),
);

final BoxDecoration weatherCardBoxDecoration = BoxDecoration(
  color: AppColors.backgroundGray,
  border: weatherCardBorder,
);

final BoxDecoration weatherDataRowBoxDecoration = BoxDecoration(
  color: AppColors.white,
  border: weatherDataRowBorder,
);

final BorderSide thinGrayBorderSide =
    BorderSide(color: AppColors.dividerGray, width: 0.5);

final Border weatherDataRowBorder = Border(
  bottom: BorderSide(color: AppColors.dividerGray, width: 0.8),
  left: thinGrayBorderSide,
  right: thinGrayBorderSide,
);

final Border weatherCardBorder = Border(
  bottom: thinGrayBorderSide,
  top: thinGrayBorderSide,
  left: thinGrayBorderSide,
  right: thinGrayBorderSide,
);
