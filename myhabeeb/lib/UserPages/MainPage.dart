// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import "package:myhabeeb/UserPages/Home.dart";
import "package:myhabeeb/UserPages/Profile.dart";
import "package:myhabeeb/UserPages/categories.dart";
import "package:myhabeeb/UserPages/shopprofile.dart";

import "package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart";
import 'package:icons_plus/icons_plus.dart';






class UserNavBar extends StatefulWidget {
  const UserNavBar({super.key});

  @override
  State<UserNavBar> createState() => _UserNavBarState();
}

PersistentTabController _controller = PersistentTabController(initialIndex: 2);

class _UserNavBarState extends State<UserNavBar> {
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 2);
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when the widget is removed
    super.dispose();
  }

  List<PersistentTabConfig> _tabs() => [
        PersistentTabConfig(
          screen: ProfilePage(),
          item: ItemConfig(
            textStyle: TextStyle(
                              color: Colors.blue[900],
                fontSize: 12,
                fontWeight: FontWeight.normal,
                fontFamily: 'Cairo'),
            icon: const Icon(Iconsax.profile_circle_bold, size: 35),
            title: "الصفحة الشخصية",
          ),
        ),
        PersistentTabConfig(
          screen: HomePage(),
          item: ItemConfig(
            textStyle: TextStyle(
                              color: Colors.blue[900],
                fontSize: 12,
                fontWeight: FontWeight.normal,
                fontFamily: 'Cairo'),
            icon: const Icon(
              HeroIcons.shopping_cart,
              size: 35,
            ),
            title: "السلة",
          ),
        ),
        PersistentTabConfig(
          screen: HomePage(),
          item: ItemConfig(
            icon: Icon(
            IonIcons.home,
              color: Colors.white,
            ),
            iconSize: 50,
          ),
        ),
        PersistentTabConfig(
          screen: CategoriesPage(),
          item: ItemConfig(
            textStyle: TextStyle(
                              color: Colors.blue[900],
                fontSize: 12,
                fontWeight: FontWeight.normal,
                fontFamily: 'Cairo'),
            icon: const Icon(
             HeroIcons.banknotes,
             size: 30,
            ),
            title: "الاقسام",
          ),
        ),
        PersistentTabConfig(
          screen: ShopProfilePage(),
          item: ItemConfig(
            textStyle: TextStyle(
                color: Colors.green,
                fontSize: 12,
                fontWeight: FontWeight.normal,
                fontFamily: 'Cairo'),
            icon: const Icon( IonIcons.information_circle,size: 30,),
            title: "عن المحل",
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) => PersistentTabView(
        controller: _controller,
        backgroundColor: Colors.white,
        tabs: _tabs(),
        navBarHeight: 65,
        navBarBuilder: (navBarConfig) => Style14BottomNavBar(
          navBarConfig: navBarConfig,
        ),
      );
}
