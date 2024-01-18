import 'package:banner_listtile/banner_listtile.dart';
import 'package:flutter/material.dart';

import '../../../theme_data.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: categories.length,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) => BannerListTile(
              showBanner: false,
              height: 80,
              backgroundColor: amenityPrimary,
              borderSide: const BorderSide(color: amenityPrimary),
              imageContainerSize: double.infinity,
              trailing: const Icon(Icons.chevron_right, color: amenityPrimary),
              title: Text(categories[index].name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  )),
              onTap: () {},
              elevation: 3,
              imageContainer: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(path + categories[index].image),
                  ))),
              borderRadius: BorderRadius.circular(10),
            ));
  }
}

String path = "assets/categoryImages/";

/// Todo: categories are kept hardcoded to reduce overhead comparisons on backend
List<Category> categories = const [
  Category(name: "Apparel", image: "apparel.jpg"),
  Category(name: "Baby", image: "baby.jpg"),
  Category(name: "Bath", image: "bath.jpg"),
  Category(name: "Cars", image: "cars.jpg"),
  Category(name: "Cellphone", image: "cellphone.jpg"),
  // add more as needed
];

class Category {
  final String name, image;

  const Category({required this.name, required this.image});
}
