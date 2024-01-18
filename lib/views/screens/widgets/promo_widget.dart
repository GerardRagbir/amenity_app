import 'package:amenity/views/screens/widgets/promo_tile.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../../models/promo_model.dart';

class PromoWidget extends StatelessWidget {
  const PromoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Swiper(
        controller: SwiperController(),
        allowImplicitScrolling: true,
        autoplay: true,
        axisDirection: AxisDirection.left,
        autoplayDisableOnInteraction: false,
        containerHeight: 200,
        containerWidth: double.infinity,
        itemWidth: MediaQuery.of(context).size.width * 0.75,
        itemHeight: double.infinity,
        fade: 0.1,
        layout: SwiperLayout.DEFAULT,
        itemCount: samplePromos.length,
        loop: true,
        duration: 1000,
        autoplayDelay: 3000,
        curve: Curves.easeInToLinear,
        physics: const ClampingScrollPhysics(),
        indicatorLayout: PageIndicatorLayout.SCALE,
        control: const SwiperControl(
            color: Colors.white, padding: EdgeInsets.symmetric(horizontal: 12)),
        pagination: const SwiperPagination(
            builder: DotSwiperPaginationBuilder(
                space: 5,
                activeSize: 18,
                size: 6,
                activeColor: Colors.white,
                color: Colors.white),
            alignment: Alignment.bottomCenter),
        itemBuilder: (context, index) {
          return CuratedTile(samplePromos[index]);
        },
      ),
    );
  }
}
