import 'package:flutter/material.dart';
import 'carousel_slider.dart';
import 'categories_section.dart';
import 'trending_offers_section.dart';
import 'brands_section.dart';
import 'contact_us_section.dart';
import '../../styles.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/bottom_navigation_bar.dart';
import '../../widgets/buttons.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: ListView(
          children: <Widget>[
            // Offer carousel
            OfferCarousel(),
            SizedBox(height: CarouselGapBottom),
            // Offer View all button
            Column(children: [
              Button1(title: 'View all offers', route: '/offers')
            ]),
            SizedBox(height: SectionsGap),
            CategoriesSection(),
            SizedBox(height: SectionsGap),
            TrendingOffersSection(),
            SizedBox(height: SectionsGap),
            BrandsSection(),
            SizedBox(height: SectionsGap),
            ContactUsSection(),
          ],
        ),
      ),
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(3),
    );
  }
}
