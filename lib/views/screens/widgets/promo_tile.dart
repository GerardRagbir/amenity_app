import 'package:flutter/material.dart';

import '../../../models/promo_model.dart';
import '../../../theme_data.dart';

class CuratedTile extends StatelessWidget {
  final PromoModel data;

  const CuratedTile(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        color: Colors.white,
        shadowColor: amenityPrimary,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  isAntiAlias: true,
                  fit: BoxFit.cover,
                  opacity: 0.9,
                  image: NetworkImage(data.promoImg))),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Chip(
                      elevation: 10,
                      shadowColor: Colors.black87,
                      backgroundColor: amenityPrimary,
                      avatar: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(data.orgImg))),
                      ),
                      label: Text(
                        data.orgName,
                        style: const TextStyle(color: Colors.white),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }
}
