import 'package:flutter/material.dart';

import '../../../theme_data.dart';

class StarView extends StatefulWidget {
  const StarView({super.key});

  @override
  State<StarView> createState() => _StarViewState();
}

class _StarViewState extends State<StarView> {
  late ListViewStates starViewState;

  @override
  void initState() {
    starViewState = ListViewStates.grid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          starTitle(),
          Expanded(
            child: AnimatedContainer(
                duration: const Duration(microseconds: 150),
                child: starViewState == ListViewStates.list
                    ? listContainer()
                    : gridContainer()),
          ),
        ]);
  }

  Widget gridContainer() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      itemCount: images.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 8,
          mainAxisSpacing: 6),
      itemBuilder: (context, index) => Card(
        clipBehavior: Clip.hardEdge,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: GridTile(
          footer: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              amenityPrimary.withOpacity(0.9),
              amenityPrimary.withOpacity(0.2)
            ])),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                    onPressed: () {},
                    color: Colors.white,
                    icon: const Icon(Icons.star_outline)),
                IconButton(
                    onPressed: () {},
                    color: Colors.white,
                    icon: const Icon(Icons.add_shopping_cart))
              ],
            ),
          ),
          header: Container(
            alignment: Alignment.centerLeft,
            height: 50,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 8, right: 2),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              amenityPrimary.withOpacity(0.95),
              amenityPrimary.withOpacity(0.25)
            ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
            child: Text(items[index],
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13),
                textAlign: TextAlign.start,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.ellipsis),
          ),
          child: Hero(
            tag: items[index],
            child: Image.network(
              images[index],
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget listContainer() {
    return ListView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: double.infinity,
            height: 120,
            child: Card(
              surfaceTintColor: amenityPrimary,
              elevation: 10,
              clipBehavior: Clip.hardEdge,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Hero(
                    tag: items[index],
                    child: Container(
                      width: 100,
                      height: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(images[index]))),
                    ),
                  ),
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(items[index],
                                    softWrap: true,
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal)),
                                Text(items[index],
                                    softWrap: true,
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal)),
                              ])))
                ],
              ),
            ),
          );
        });
  }

  Widget starTitle() {
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
            'Starred',
            softWrap: false,
            maxLines: 1,
            style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
              splashRadius: 1,
              onPressed: () {
                starViewState = ListViewStates.grid;
                setState(() {});
              },
              icon: const Icon(Icons.grid_view),
              color: starViewState == ListViewStates.grid
                  ? amenityPrimary
                  : Colors.black87),
          IconButton(
              splashRadius: 1,
              onPressed: () {
                starViewState = ListViewStates.list;
                setState(() {});
              },
              icon: const Icon(Icons.view_list),
              color: starViewState == ListViewStates.list
                  ? amenityPrimary
                  : Colors.black87),
        ],
      ),
    );
  }
}

enum ListViewStates { list, grid }

List<int> titles = [1, 2, 3, 4, 5, 6, 7];

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
