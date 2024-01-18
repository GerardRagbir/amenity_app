import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';

import '../../../theme_data.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SwipeButton.expand(
          enabled: true,
          width: MediaQuery.of(context).size.width * 2 / 3,
          elevationTrack: 8,
          elevationThumb: 10,
          activeThumbColor: amenityPrimary,
          activeTrackColor: Colors.white,
          thumb: const Icon(Icons.double_arrow_rounded),
          duration: const Duration(seconds: 1),
          onSwipeEnd: () {},
          onSwipe: () {
            Navigator.of(context).pop();
          },
          child: const Text("Complete Transaction")),
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          automaticallyImplyLeading: true,
          centerTitle: false,
          titleSpacing: 0.5,
          leadingWidth: 40,
          title: const Text('Return to Cart')),
      backgroundColor: Colors.cyan.shade800,
      body: const Center(
        child: Text("Payment processor unavailable",
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white70,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
