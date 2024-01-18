class PromoModel {
  final String promoImg;
  final String orgImg;
  final String orgName;
  final String orgUri;

  PromoModel({
    required this.orgImg,
    required this.orgName,
    required this.orgUri,
    required this.promoImg,
  });
}

List<PromoModel> samplePromos = [
  PromoModel(
    orgName: "Marios Pizzeria",
    orgImg: rndImg,
    orgUri: "https://mymarios.com",
    promoImg: rndImg,
  ),
  PromoModel(
    orgName: "PricesmartTT",
    orgImg: rndImg,
    orgUri: "www.pricesmart.com",
    promoImg: rndImg,
  ),
];

String rndImg = "https://picsum.photos/200/300";
