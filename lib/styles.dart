import 'package:flutter/material.dart';

// Font sizes
const LargeTextSize = 22.0;
const MediumTextSize = 20.0;
const BodyTextSize = 16.0;
const ButtonTextSize = 13.0;

// Default Colors
const AccentColor = Color(0xff4267B2);
const AccentColorShadow = Color(0x804267B2);
const SecondaryColor = Color(0xffFFBE4A);
const BackgroundColor = Color(0xfff2f2f2);
const Neumorphism1 = Colors.black12;
const Neumorphism2 = Colors.white;
const LightBoxShadow = Color(0x0F000000);
const DefaultGreenColor = Color(0xff40E78D);
const DefaultRedColor = Color(0xffFF6565);
const DefaultShadowGreenColor = Color(0x8040E78D);
const DefaultShadowRedColor = Color(0x80FF6565);
const SecondaryColorDropShadow = Color(0x55F2BB2D);
const LoginInputBgColor = Color(0xffF7F7F7);

// Constrains
const double ScreenPadding = 20;
const double SectionsGap = 60;
const double CarouselGapBottom = 10;
const double OfferBorderRadius = 20;

// Default Text properties
const String DefaultFontFamily = "Poppins";
const Color DefaultFontColor = Color(0xff2E3033);
const Color SecondaryTextColor = Color(0xff2E3033);

// Text styles
const TextStyle TitleTextStyle = TextStyle(
  fontFamily: DefaultFontFamily,
  fontSize: LargeTextSize,
  fontWeight: FontWeight.w800,
  color: DefaultFontColor,
);

// App Bar theme
const AppBarTheme MyAppBarTheme = AppBarTheme(
  color: BackgroundColor,
  elevation: 0,
);

// App bar leading icon theme
const IconThemeData AppBarLeadingIconTheme = IconThemeData(
  color: DefaultFontColor,
);

const TextStyle Button1TextStyle = TextStyle(
  fontSize: ButtonTextSize,
  fontFamily: DefaultFontFamily,
  color: AccentColor,
  shadows: <Shadow>[
    Shadow(
      blurRadius: 30,
      color: Color(0xF14267B2),
      offset: Offset.zero,
    ),
  ],
);

const TextStyle BodyTextStyle1 = TextStyle(
  color: DefaultFontColor,
  fontSize: ButtonTextSize,
  fontWeight: FontWeight.w600,
);

const TextStyle ProductGridItemTitle = TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: BodyTextSize,
  color: DefaultFontColor,
  fontFamily: DefaultFontFamily,
);

const TextStyle ProductInfoTitle = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: LargeTextSize,
  color: DefaultFontColor,
);

const TextStyle RatingWidgetTextStyle = TextStyle(
  color: Colors.black54,
  fontWeight: FontWeight.w700,
  fontSize: BodyTextSize,
);

const TextStyle HightlightsTitleStyle = TextStyle(
  fontSize: LargeTextSize + 2,
  fontWeight: FontWeight.w600,
  color: DefaultFontColor,
);

const TextStyle HighlightBodyTextStyle = TextStyle(
  fontSize: BodyTextSize,
  color: SecondaryTextColor,
  fontWeight: FontWeight.w600,
);

const TextStyle LoginScreenTitle = TextStyle(
  fontSize: LargeTextSize + 5,
  fontWeight: FontWeight.w800,
  color: DefaultFontColor,
);

const TextStyle PlaceholderTextAddItem = TextStyle(
  fontSize: BodyTextSize,
  fontWeight: FontWeight.w500,
  color: Colors.black26,
);

const TextStyle UploadButtonTextStyle = TextStyle(
  fontSize: BodyTextSize,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);

const TextStyle AddFieldLabelStyle = TextStyle(
  color: DefaultFontColor,
  fontSize: MediumTextSize,
  fontWeight: FontWeight.w600,
  fontFamily: DefaultFontFamily,
);

const TextStyle LoginFormLabelStyle = TextStyle(
  color: DefaultFontColor,
  fontSize: BodyTextSize,
  fontWeight: FontWeight.w500,
  fontFamily: DefaultFontFamily,
);

const TextStyle InputPlaceholderTextStyle = TextStyle(
  color: Colors.black26,
  fontFamily: DefaultFontFamily,
  fontSize: BodyTextSize - 2,
);

const TextStyle inputErrorTextStyle = TextStyle(
  color: Colors.red,
  fontFamily: DefaultFontFamily,
  fontSize: BodyTextSize - 3,
  fontWeight: FontWeight.w500,
  shadows: [
    Shadow(
      color: DefaultShadowRedColor,
      offset: Offset(2, 2),
      blurRadius: 10,
    ),
  ],
);

const BoxShadow textInputShadow = BoxShadow(
  color: LightBoxShadow,
  blurRadius: 20,
  offset: Offset(0, 0),
);
