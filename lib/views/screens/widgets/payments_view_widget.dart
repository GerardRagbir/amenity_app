import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import '../../../theme_data.dart';

class PaymentsView extends StatelessWidget {
  const PaymentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic _cardStream = FirebaseFirestore.instance
        .collection(
          'users/cc',
        )
        .where(
          'cards',
          isEqualTo: true,
        )
        .snapshots();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: amenityPrimary,
          foregroundColor: Colors.white,
          title: const Text("Payment Options"),
        ),
        body: SafeArea(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return CreditCardWidget(
                cardBgColor: amenityPrimary,
                cardType: _cardStream[index]['cardType'],
                bankName: _cardStream[index]['cardProvider'],
                cardNumber: _cardStream[index]['cardNumber'],
                expiryDate: _cardStream[index]['xpDate'],
                cardHolderName: _cardStream[index]['cardholder'],
                cvvCode: _cardStream[index]['cv2'],
                obscureCardCvv: true,
                obscureCardNumber: true,
                showBackView: false,
                isChipVisible: true,
                isHolderNameVisible: false,
                isSwipeGestureEnabled: false,
                onCreditCardWidgetChange: (CreditCardBrand brand) {},
                customCardTypeIcons: <CustomCardTypeIcon>[
                  CustomCardTypeIcon(
                    cardType: _cardStream[index]['cardType'] == "mastercard"
                        ? CardType.mastercard
                        : CardType.visa,
                    cardImage: Image.asset(
                      _cardStream[index]['cardType'] == "mastercard"
                          ? 'assets/card_badges/mastercard.png'
                          : 'assets/card_badges/visa.png',
                      height: 48,
                      width: 48,
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }
}
