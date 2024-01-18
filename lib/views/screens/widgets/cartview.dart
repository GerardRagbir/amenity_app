import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share_plus/share_plus.dart';

import '../../../theme_data.dart';
import 'checkoutpage.dart';

class ShoppingCartView extends StatelessWidget {
  const ShoppingCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          shoppingCartTitle(context),
          Expanded(
            child: ListView.builder(
                itemCount: items.length,
                addRepaintBoundaries: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                clipBehavior: Clip.hardEdge,
                itemBuilder: (context, index) => CartItem(
                    itemName: items[index],
                    sellerName: 'Seller $index',
                    image: images[index],
                    quantity: qty[index],
                    cost: costs[index] * qty[index])),
          ),
        ]);
  }
}

List items = [
  "Engineering Management for the Rest of Us",
  "Sony Playstation 5 (NEW)",
  "Avengers - Infinity War Bluray",
  "Amazon Gift Card - \$100"
];

List images = [
  "https://www.goodillustration.com/blog/wp-content/uploads/2021/09/BLOG-640.jpg",
  "https://www.ctscollege.com/assets/images/ps5.jpg",
  "https://m.media-amazon.com/images/I/81GIBVvDeaL.jpg",
  "https://egsiteassets.images.egifter.com/Images/GiftCardFaceplates/External/AMAZON_fp01.png"
];

List<int> qty = [1, 1, 1, 3];
List<double> costs = [39.95, 499.99, 84.99, 100.00];

double subtotal(List<double> cartList) {
  return cartList.fold(0, (previous, current) => previous + current);
}

gotoCheckout(BuildContext context, MaterialPageRoute route) {
  try {
    Navigator.of(context).push(route);
  } catch (e) {
    debugPrint(e.toString());
  } finally {
    debugPrint("Went to checkout");
  }
}

Widget shoppingCartTitle(BuildContext context) {
  return Container(
    color: Colors.white,
    width: double.infinity,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(width: 10),
        const Text(
          'Shopping Cart',
          softWrap: false,
          maxLines: 1,
          style: TextStyle(
              color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Tooltip(
          message: 'Go to checkout',
          child: MaterialButton(
            onPressed: () {
              gotoCheckout(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CheckoutPage()));
            },
            enableFeedback: true,
            textColor: amenityPrimary,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$${subtotal(costs).toStringAsFixed(2)}",
                    softWrap: false,
                    textHeightBehavior: const TextHeightBehavior(
                        leadingDistribution: TextLeadingDistribution.even),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        shadows: [
                          Shadow(
                              color: Colors.black12,
                              offset: Offset(0, 1),
                              blurRadius: 1)
                        ])),
                const Icon(Icons.keyboard_double_arrow_right_outlined)
              ],
            ),
          ),
        )
      ],
    ),
  );
}

class CartItem extends StatelessWidget {
  const CartItem(
      {super.key,
      required this.itemName,
      required this.sellerName,
      this.image,
      required this.quantity,
      required this.cost});

  final String itemName, sellerName;
  final String? image;
  final int quantity;
  final double cost;

  void shareItem(BuildContext context) async {
    //TODO: Share Item Function
    Share.share(itemName, subject: "Check out this item on Amenity!");
  }

  void removeItem(BuildContext context) async {
    //TODO: Remove Item Function
    debugPrint("$itemName was deleted!");
  }

  void starItem(BuildContext context) async {
    //TODO: Star Item Function
    debugPrint("$itemName was starred!");
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: UniqueKey(),
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        dragDismissible: true,
        children: [
          SlidableAction(
            onPressed: starItem,
            autoClose: true,
            backgroundColor: amenityPrimary,
            foregroundColor: Colors.white,
            label: "Star",
            icon: Icons.star,
          ),
          SlidableAction(
            onPressed: shareItem,
            autoClose: true,
            backgroundColor: Colors.lightBlue,
            foregroundColor: Colors.white,
            label: "Share",
            icon: Icons.share,
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dragDismissible: true,
        children: [
          SlidableAction(
            onPressed: removeItem,
            autoClose: true,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            label: "Remove",
            icon: Icons.remove_circle,
          )
        ],
      ),
      child: Container(
          clipBehavior: Clip.none,
          padding: const EdgeInsets.only(right: 4),
          height: 170,
          width: double.infinity,
          child: Card(
              elevation: 0,
              child: Row(children: [
                Container(
                    height: double.infinity,
                    width: 110,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            onError: (object, error) {},
                            alignment: Alignment.center,
                            isAntiAlias: true,
                            image: NetworkImage(image!),
                            fit: BoxFit.scaleDown)),
                    child: Center(
                        child: CircleAvatar(
                            backgroundColor: amenityPrimary,
                            foregroundColor: Colors.white,
                            child: Text('$quantity')))),
                const VerticalDivider(color: Colors.transparent),
                Expanded(
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      const Divider(color: amenityPrimary),
                      Text(itemName,
                          softWrap: true,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                              color: Colors.black87)),
                      const SizedBox(height: 8),
                      const Text('Condition: New',
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.black)),
                      const SizedBox(height: 2),
                      Text('Sold by: $sellerName',
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.black)),
                      const Spacer(),
                      Text('\$${(cost * quantity).toStringAsFixed(2)}',
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.black)),
                      const Divider(color: amenityPrimary)
                    ])),
                const SizedBox(
                    width: 20,
                    height: double.maxFinite,
                    child: Center(child: Icon(Icons.drag_indicator)))
              ]))),
    );
  }
}
