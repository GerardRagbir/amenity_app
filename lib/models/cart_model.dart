class CartItemModel {
  final String itemName;
  final String itemSeller;
  final int checkoutQty;
  final double unitPrice;

  CartItemModel({
    required this.itemName,
    required this.checkoutQty,
    required this.itemSeller,
    required this.unitPrice,
  });
}
