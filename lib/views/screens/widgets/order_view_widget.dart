import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

import '../../../theme_data.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  final GroupedItemScrollController itemScrollController =
      GroupedItemScrollController();

  late int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _elements = FirebaseFirestore.instance
        .collection('orders')
        .where('buyerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: amenityPrimary,
        foregroundColor: Colors.white,
        title: const Text("Order History"),
        bottom: PreferredSize(
            preferredSize: const Size(300, 60),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: MaterialSegmentedControl(
                onSegmentTapped: (int index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                selectionIndex: selectedIndex,
                borderColor: Colors.white,
                selectedColor: Colors.white,
                unselectedColor: amenityPrimary,
                selectedTextStyle: const TextStyle(color: amenityPrimary),
                unselectedTextStyle: const TextStyle(color: Colors.white),
                borderWidth: 0.7,
                //borderRadius: 32.0,
                children: _children,
              ),
            )),
      ),
      body: StreamBuilder(
          stream: _elements,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(color: Colors.cyan);
            }

            final List<Element> orderData =
                snapshot.data!.docs.cast<Element>().toList();
            return StickyGroupedListView<Element, DateTime>(
              itemScrollController: itemScrollController,
              order: StickyGroupedListOrder.ASC,
              floatingHeader: true,
              elements: orderData,
              itemBuilder: _getItem,
              groupSeparatorBuilder: _getGroupSeparator,
              groupBy: (Element element) => DateTime(
                element.date.year,
                element.date.month,
                element.date.day,
              ),
              groupComparator: (DateTime value1, DateTime value2) =>
                  value2.compareTo(value1),
              itemComparator: (Element element1, Element element2) =>
                  element1.date.compareTo(element2.date),
            );
          }),
    );
  }
}

Map<int, Widget> _children = {
  0: SizedBox(
      width: 100,
      height: 16,
      child: Text(
        '${DateTime.now().year}',
        textAlign: TextAlign.center,
      )),
  1: const SizedBox(
      width: 80,
      height: 16,
      child: Text(
        'All',
        textAlign: TextAlign.center,
      )),
};

Widget _getGroupSeparator(Element element) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16, top: 12),
    child: SizedBox(
      height: 35,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 160,
          height: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: amenityPrimary,
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Text(
            _dateAlias(element.date),
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );
}

String _dateAlias(DateTime date) {
  DateTime today = DateTime.now();
  if (today.day == date.day &&
      today.month == date.month &&
      today.year == date.year) {
    return "TODAY";
  } else if (today.day - 1 == date.day &&
      today.month == date.month &&
      today.year == date.year) {
    return "YESTERDAY";
  } else {
    return '${date.day} - ${_monthAlias(date.month)} - ${date.year}';
  }
}

String _monthAlias(int month) {
  switch (month) {
    case 1:
      return "Jan";
    case 2:
      return "Feb";
    case 3:
      return "Mar";
    case 4:
      return "Apr";
    case 5:
      return "May";
    case 6:
      return "Jun";
    case 7:
      return "Jul";
    case 8:
      return "Aug";
    case 9:
      return "Sep";
    case 10:
      return "Oct";
    case 11:
      return "Nov";
    case 12:
      return "Dec";
    default:
      return "NA";
  }
}

Widget _getItem(BuildContext context, Element element) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6.0),
    ),
    elevation: 8.0,
    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: SizedBox(
      child: ListTile(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: const CircleAvatar(
          radius: 30,
          backgroundColor: amenityPrimary,
        ),
        title: Text(
          element.item,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
        ),
        trailing: element.completed
            ? const Tooltip(
                message: 'Your order was fulfilled.',
                child: Icon(
                  Icons.check_circle,
                  color: amenityPrimary,
                ),
              )
            : const Tooltip(
                message: 'Your order has not yet been completed.',
                child: Icon(
                  Icons.pending,
                  color: Colors.grey,
                ),
              ),
      ),
    ),
  );
}

class Element {
  DateTime date;
  String item;
  bool completed;

  Element(this.date, this.item, this.completed);
}

// List<Element> _elements = <Element>[
//   Element(DateTime(2020, 6, 24), 'Nike Gym Pants - Black', true),
//   Element(DateTime(2020, 6, 24), 'Stationary', true),
//   Element(DateTime(2021, 6, 25), 'Adidas Messenger Bag', true),
//   Element(DateTime(2021, 6, 25), 'Avengers Infinity War Blu-ray', true),
//   Element(DateTime(2022, 9, 25), 'Instant Chicken Ramen - 12pk', true),
//   Element(DateTime(2023, 1, 01), 'Kitchen Set - Mauve', true),
//   Element(DateTime(2023, 1, 23), 'Samsung 64GB storage drive', true),
//   Element(DateTime(2023, 1, 24), 'Mothers Car Polish', false),
//   Element(DateTime(2023, 1, 24), 'Apple MacBook Pro 14" Laptop', true),
// ];
