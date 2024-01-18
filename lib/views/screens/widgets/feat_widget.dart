import 'package:amenity/views/screens/inner_screen/product_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../provider/rec_provider.dart';
import '../../../theme_data.dart';
import '../widgets/daily_deals.dart';
import '../widgets/promo_widget.dart';

class FeaturedView extends StatelessWidget {
  const FeaturedView({Key? key}) : super(key: key);

  static final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection(
          'products',
        )
        .where(
          'recommended',
          isEqualTo: true,
        )
        .snapshots();

    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        clipBehavior: Clip.hardEdge,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        controller: _scrollController,
        child: Column(children: [
          sectionTitle("Promotions"),
          const PromoWidget(),
          const SizedBox(height: 30),
          sectionTitle("Just For You"),
          SizedBox(
              height: 100,
              width: double.infinity,
              child: StreamBuilder(
                stream: _productsStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }
                  if (snapshot.data?.size == 0) {
                    return Text(
                      "No recommendations yet!",
                      textAlign: TextAlign.center,
                    );
                  }
                  return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 12,
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 5);
                      },
                      itemBuilder: (context, index) {
                        final productData = snapshot.data!.docs[index];
                        return ForYouWidget(productData);
                      });
                },
              )),
          const SizedBox(height: 30),
          sectionTitle("Daily Deals"),
          const DailyDealsWidget(),
          const SizedBox(height: 30),
          sectionTitle("Nearby"),
          SizedBox(
            height: 400,
            width: MediaQuery.of(context).size.width * 0.95,
            child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: Colors.white,
                elevation: 2,
                shadowColor: amenityPrimary,
                child: FlutterMap(
                    options: const MapOptions(
                      initialCenter: LatLng(10.6, -61.5),
                      initialZoom: 16,
                    ),
                    children: [TileLayer(urlTemplate: mapUri)])),
          ),
          const SizedBox(height: 50),
        ]));
  }
}

TextStyle titleStyle() => const TextStyle(
    color: amenityPrimary, fontWeight: FontWeight.bold, fontSize: 20);

Widget sectionTitle(String title) => Container(
    padding: const EdgeInsets.only(left: 20),
    alignment: Alignment.centerLeft,
    height: 55,
    child: Text(title, style: titleStyle()));

String mapUri = "";

/// TODO: add map URI here or replace map provider service

class ForYouWidget extends ConsumerStatefulWidget {
  final dynamic productData;
  ForYouWidget(this.productData, {super.key});

  @override
  _ForYouWidgetState createState() => _ForYouWidgetState();
}

class _ForYouWidgetState extends ConsumerState<ForYouWidget> {
  @override
  Widget build(BuildContext context) {
    final _recProvider = ref.read(recProvider.notifier);
    ref.watch(recProvider);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProductDetail(productData: widget.productData)));
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            backgroundImage:
                NetworkImage(widget.productData['productImages'][0]),
            backgroundColor: amenityPrimary,
            radius: 40,
          ),
          Text(
            widget.productData['productName'].toString(),
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
          ),
        ],
      ),
    );
    ();
  }
}
