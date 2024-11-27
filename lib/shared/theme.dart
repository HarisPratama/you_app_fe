import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double defaultMargin = 23.0;
double secondMargin = 5.0;
double navMargin = 18.0;

Color linearColor1 = Color(0xff1F4247);
Color linearColor2 = Color(0xff0D1D23);
Color linearColor3 = Color(0xff09141A);
Color kWhiteColor = Color(0xffFFFFFF);
Color kGrayColor = Color.fromRGBO(255, 255, 255, 0.33);
Color kBlackColor = Color(0xff1F1449);
Color kSecondaryBlackColor = Color(0xff1F1449);


TextStyle whiteTextStyle = GoogleFonts.inter(
  color: kWhiteColor,
);
TextStyle grayTextStyle = GoogleFonts.inter(
  color: kGrayColor,
);
TextStyle goldGradientTextStyle = GoogleFonts.inter(
  foreground: Paint()..shader = const LinearGradient(
      begin: Alignment(-0.74, -1.0), // Approximate the 74.08deg angle
      end: Alignment(1.0, 1.0),
      colors: [
        Color(0xFF94783E), // #94783E
        Color(0xFFF3EDA6), // #F3EDA6
        Color(0xFFF8FAE5), // #F8FAE5
        Color(0xFFFFE2BE), // #FFE2BE
        Color(0xFFD5BE88), // #D5BE88
        Color(0xFFF8FAE5), // #F8FAE5
        Color(0xFFD5BE88), // #D5BE88
      ],
      stops: [
        -0.068,  // -6.8%
        0.1676,  // 16.76%
        0.305,   // 30.5%
        0.496,   // 49.6%
        0.7856,  // 78.56%
        0.8901,  // 89.01%
        1.0043,  // 100.43%
      ],
    ).createShader(const Rect.fromLTWH(0, 0, 200, 50)),
);

TextStyle acientGradientTextStyle = GoogleFonts.inter(
  foreground: Paint()..shader = const LinearGradient(
      begin: Alignment(-0.74, -1.0), // Approximate the 74.08deg angle
      end: Alignment(1.0, 1.0),
      colors: [
        Color(0xFFABFFFD), // #94783E
        Color(0xFF4599DB), // #F3EDA6
        Color(0xFFAADAFF), // #F8FAE5
      ],
      stops: [
        -0.068,  // -6.8%
        0.1676,  // 16.76%
        0.305,   // 30.5%
      ],
    ).createShader(const Rect.fromLTWH(0, 0, 200, 50)),
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;
