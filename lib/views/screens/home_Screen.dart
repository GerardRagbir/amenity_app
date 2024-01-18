import 'package:amenity/vendor/authentication/vendor_register_screen.dart';
import 'package:amenity/vendor/screens/vendor_account_screen.dart';
import 'package:amenity/vendor/screens/vendor_orders_screen.dart';
import 'package:amenity/views/screens/bottomNav_screens/acount_screen.dart';
import 'package:amenity/views/screens/widgets/banner_widget.dart';
import 'package:amenity/views/screens/widgets/cartview.dart';
import 'package:amenity/views/screens/widgets/category_item.dart';
import 'package:amenity/views/screens/widgets/feat_widget.dart';
import 'package:amenity/views/screens/widgets/header.dart';
import 'package:amenity/views/screens/widgets/order_view_widget.dart';
import 'package:amenity/views/screens/widgets/payments_view_widget.dart';
import 'package:amenity/views/screens/widgets/popular_products.dart';
import 'package:amenity/views/screens/widgets/recommended_product.dart';
import 'package:amenity/views/screens/widgets/reuse_text_widget.dart';
import 'package:amenity/views/screens/widgets/search.dart';
import 'package:amenity/views/screens/widgets/shopping_view.dart';
import 'package:amenity/views/screens/widgets/starred_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../../theme_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.20),
        child: HeaderWidget(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            BannerArea(),
            CategoryItem(),
            ResuseTextWidget(title: 'Recommend for you', subtitle: 'View all'),
            RecommendedProduct(),
            ResuseTextWidget(
              title: 'Popular',
              subtitle: 'View all',
            ),
            PopularProducts(),
          ],
        ),
      ),
    );
  }
}

class HomePage extends HookConsumerWidget {
  HomePage({super.key});

  final _pageController = PageController(initialPage: 0);

  late int _currentPage = 0;

  late bool storeExists = false;

  late bool darkModeEnabled = false;

  void updatePage(int index) {
    _currentPage = index;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> pages = [
      FeaturedView(),
      ShoppingView(),
      StarView(),
      ShoppingCartView(),
      Search(results: ref),
    ];

    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _pageController.jumpToPage(4);
          },
          foregroundColor: Colors.white,
          backgroundColor: amenityPrimary,
          child: const Icon(Icons.search),
        ),
        bottomNavigationBar: StylishBottomBar(
          hasNotch: true,
          currentIndex: _currentPage != 4 ? _currentPage : 0,
          onTap: (index) {
            _currentPage = index;
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 400),
                curve: Curves.linearToEaseOut);
          },
          fabLocation: StylishBarFabLocation.end,
          option: AnimatedBarOptions(
              barAnimation: BarAnimation.blink,
              inkColor: amenityPrimary,
              iconStyle: IconStyle.animated,
              padding: const EdgeInsets.symmetric(horizontal: 0)),
          // unselectedIconColor: Colors.grey,
          // barStyle: BubbleBarStyle.vertical,
          items: [
            barItem(asset: 'assets/home_icons/shop.png', title: 'Featured'),
            barItem(asset: 'assets/home_icons/sale.png', title: 'Shop'),
            barItem(asset: 'assets/home_icons/starred.png', title: 'Starred'),
            barItem(asset: 'assets/home_icons/cart.png', title: 'Cart'),
          ],
        ),
        body: PageView.builder(
            pageSnapping: true,
            physics: const NeverScrollableScrollPhysics(),
            padEnds: false,
            allowImplicitScrolling: true,
            itemCount: pages.length,
            controller: _pageController,
            onPageChanged: updatePage,
            itemBuilder: (context, index) {
              return pages[index];
            }),
        drawerEnableOpenDragGesture: true,
        drawerScrimColor: amenityPrimary,
        drawer: Drawer(
          elevation: 1,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(50),
            ),
          ),
          child: Stack(
            fit: StackFit.loose,
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              SizedBox.expand(
                  child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton.small(
                            elevation: 1,
                            tooltip: "",
                            heroTag: "darkmode",
                            backgroundColor: amenityPrimary,
                            foregroundColor: Colors.white,
                            onPressed: () {
                              darkModeEnabled = !darkModeEnabled;
                              Navigator.of(context).pop();
                            },
                            child: darkModeEnabled
                                ? const Icon(Icons.light_mode)
                                : const Icon(Icons.dark_mode)),
                        FloatingActionButton.small(
                            elevation: 1,
                            tooltip: "",
                            heroTag: "notifications",
                            backgroundColor: amenityPrimary,
                            foregroundColor: Colors.white,
                            onPressed: () {},
                            child: const Icon(Icons.notifications)),
                        FloatingActionButton.small(
                            elevation: 1,
                            tooltip: "",
                            heroTag: "policies",
                            backgroundColor: amenityPrimary,
                            foregroundColor: Colors.white,
                            onPressed: () {},
                            child: const Icon(Icons.policy)),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12, top: 12, bottom: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Shopping Experience",
                          softWrap: true,
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Spacer(),
                        Tooltip(
                          verticalOffset: 12,
                          height: 50,
                          triggerMode: TooltipTriggerMode.tap,
                          showDuration: Duration(seconds: 3),
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          enableFeedback: true,
                          excludeFromSemantics: true,
                          textStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              color: Colors.white),
                          message:
                              "Manage your shopping experience here. View current and past orders, your saved addresses, payment profiles and your membership settings.",
                          child: Icon(
                            Icons.help,
                            color: Colors.black38,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ListTile(
                        title: const Text('Orders'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const OrdersView()));
                        },
                      ),
                      ListTile(
                        title: const Text('Payment Options'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const PaymentsView()));
                        },
                      ),
                      ListTile(
                        title: const Text('Address Book'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {},
                      ),
                    ],
                  ),
                  const Divider(
                    height: 30,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12, top: 12, bottom: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "My Account",
                          softWrap: true,
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Spacer(),
                        Tooltip(
                          verticalOffset: 12,
                          height: 50,
                          triggerMode: TooltipTriggerMode.tap,
                          showDuration: Duration(seconds: 3),
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          enableFeedback: true,
                          excludeFromSemantics: true,
                          textStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              color: Colors.white),
                          message:
                              'Manage your user account, including your avatar, displayed name, preferences and so much more.',
                          child: Icon(
                            Icons.help,
                            color: Colors.black38,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ListTile(
                        title: const Text('Manage my profile'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AccountScreen()));
                        },
                      ),
                      ListTile(
                        title: const Text('Premium Membership'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {},
                      ),
                    ],
                  ),
                  const Divider(
                    height: 30,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12, top: 12, bottom: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Storefront",
                          softWrap: true,
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Spacer(),
                        Tooltip(
                          verticalOffset: 12,
                          height: 50,
                          triggerMode: TooltipTriggerMode.tap,
                          showDuration: Duration(seconds: 3),
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          enableFeedback: true,
                          excludeFromSemantics: true,
                          textStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              color: Colors.white),
                          message:
                              'Host and manage your own business on Amenity. Manage your content, banking and more all from this convenient storefront.',
                          child: Icon(
                            Icons.help,
                            color: Colors.black38,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: storeExists
                        ? [
                            ListTile(
                              title: Text('Store Profile'),
                              trailing: Icon(Icons.chevron_right),
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return VendorAccountScreen();
                                }));
                              },
                            ),
                            ListTile(
                              title: Text('My Orders'),
                              trailing: Icon(Icons.chevron_right),
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return VendorOrderScreen();
                                }));
                              },
                            ),
                            ListTile(
                              title: Text('Banking Profile'),
                              trailing: Icon(Icons.chevron_right),
                              onTap: () {},
                            ),
                          ]
                        : [
                            ListTile(
                              title: const Text('Register a Store'),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VendorRegisterScreen()));
                              },
                            ),
                          ],
                  )
                ],
              )),
              Positioned(
                right: -95,
                width: 100,
                top: kToolbarHeight,
                bottom: kToolbarHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RotatedBox(
                      quarterTurns: 1,
                      child: RichText(
                        text: TextSpan(
                          text: 'Hello, ',
                          children: <TextSpan>[
                            TextSpan(
                              text: "${ref ?? "Username"}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50),
                            )
                          ],
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontSize: 50),
                        ),
                        softWrap: false,
                        maxLines: 1,
                        textHeightBehavior: const TextHeightBehavior(
                            applyHeightToFirstAscent: true,
                            applyHeightToLastDescent: true,
                            leadingDistribution: TextLeadingDistribution.even),
                      ),
                    ),
                    const Spacer(),
                    const CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      foregroundColor: amenityPrimary,
                      child: Icon(Icons.close),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: kToolbarHeight,
          automaticallyImplyLeading: true,
          scrolledUnderElevation: 0,
          //toolbarTextStyle: GoogleFonts.abel(),
          backgroundColor: Colors.white,
          foregroundColor: amenityPrimary,
          iconTheme: const IconThemeData(color: amenityPrimary, size: 24),
          actionsIconTheme:
              const IconThemeData(color: amenityPrimary, size: 24),
          centerTitle: true,
          title: SizedBox(
            width: 150,
            child: SvgPicture.asset(
              "assets/images/amenity_name.svg",
              fit: BoxFit.scaleDown,
            ),
          ),
        ));
  }
}

BottomBarItem barItem({required String asset, required String title}) {
  return BottomBarItem(
      backgroundColor: Colors.transparent,
      selectedColor: amenityPrimary,
      unSelectedColor: Colors.black54,
      icon: Image.asset(
        asset,
        fit: BoxFit.scaleDown,
        width: 22,
        height: 22,
        color: amenityPrimary,
        alignment: Alignment.center,
        isAntiAlias: true,
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
      ));
}
