import 'package:banner_listtile/banner_listtile.dart';
import 'package:flutter/material.dart';

import '../../../theme_data.dart';

class StoreView extends StatelessWidget {
  const StoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: 10,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) => BannerListTile(
              showBanner: true,
              height: 100,
              backgroundColor: Colors.white,
              bannerColor: amenityPrimary,
              borderRadius: BorderRadius.circular(10),
              imageContainerShapeZigzagIndex: index,
            ));
  }
}
