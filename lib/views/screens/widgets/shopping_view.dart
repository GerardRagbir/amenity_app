import 'dart:developer';

import 'package:amenity/views/screens/widgets/store_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

import '../../../theme_data.dart';
import 'category_view_widget.dart';

class ShoppingView extends StatefulWidget {
  const ShoppingView({super.key});

  @override
  State<ShoppingView> createState() => _ShoppingViewState();
}

class _ShoppingViewState extends State<ShoppingView> {
  late GroupButtonController _buttonController;
  late PageController _shopPageController;

  @override
  void initState() {
    _shopPageController = PageController(initialPage: 0);
    _buttonController = GroupButtonController(selectedIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          height: 80,
          child: GroupButton(
            controller: _buttonController,
            enableDeselect: false,
            maxSelected: 1,
            onSelected: (data, index, selected) {
              _shopPageController.jumpToPage(index);
              log("$data : $index : $selected");
            },
            options: GroupButtonOptions(
                alignment: Alignment.center,
                unselectedColor: Colors.white,
                selectedColor: amenityPrimary,
                unselectedBorderColor: Colors.white,
                selectedBorderColor: amenityPrimary,
                elevation: 1,
                buttonHeight: 40,
                buttonWidth: size.width / 4,
                borderRadius: BorderRadius.circular(10),
                textAlign: TextAlign.center,
                selectedTextStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
                groupingType: GroupingType.row,
                groupRunAlignment: GroupRunAlignment.spaceAround,
                crossGroupAlignment: CrossGroupAlignment.center,
                mainGroupAlignment: MainGroupAlignment.spaceEvenly),
            isRadio: true,
            buttons: const ["Category", "Store", "Map"],
          ),
        ),
        Expanded(
            child: PageView.builder(
          itemCount: 3,
          controller: _shopPageController,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => storePages[index],
        ))
      ],
    );
  }
}

List<Widget> storePages = [
  const CategoryView(),
  const StoreView(),
  Container(
    color: Colors.orange.shade50,
  ),
];
