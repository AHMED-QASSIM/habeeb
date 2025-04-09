// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import "package:myhabeeb/AdminPages/AddItemPage.dart";
import "package:myhabeeb/AdminPages/CustomersPage.dart";
import "package:myhabeeb/AdminPages/InvoicesPage.dart";
import "package:myhabeeb/AdminPages/notifications.dart";
import "package:myhabeeb/AdminPages/categories_page.dart";

import "package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart";
import 'package:icons_plus/icons_plus.dart';






class AdminNavBar extends StatefulWidget {
  const AdminNavBar({super.key});

  @override
  State<AdminNavBar> createState() => _AdminNavBarState();
}

PersistentTabController _controller = PersistentTabController(initialIndex: 2);

class _AdminNavBarState extends State<AdminNavBar> {
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
          screen: Notifiactions(),
          item: ItemConfig(
                        activeForegroundColor: Colors.blue[900]!,

            textStyle: TextStyle(
                              color: Colors.blue[900],
                fontSize: 12,
                fontWeight: FontWeight.normal,
                fontFamily: 'Cairo'),
            icon: const Icon(Icons.notification_add, size: 35),
            title: " الاشعارات",
          ),
        ),
        PersistentTabConfig(
          screen: Customerspage(),
          item: ItemConfig(
                        activeForegroundColor: Colors.blue[900]!,

            textStyle: TextStyle(
                              color: Colors.blue[900],
                fontSize: 12,
                fontWeight: FontWeight.normal,
                fontFamily: 'Cairo'),
            icon: const Icon(
               IonIcons.person,
              size: 35,
            ),
            title: "الزبائن",
          ),
        ),
        PersistentTabConfig(

          screen: Invoices(),
          item: ItemConfig(
            
            activeForegroundColor: Colors.blue[900]!,
            icon: Icon(
            IonIcons.home,
              color: Colors.white,
            ),
            iconSize: 50,
          ),
        ),
        PersistentTabConfig(
          screen: CategoryPage(),
          item: ItemConfig(
            activeForegroundColor: Colors.blue[900]!,
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
          screen: AddItemspage(),
          item: ItemConfig(
                        activeForegroundColor: Colors.blue[900]!,

            textStyle: TextStyle(
                color: Colors.green,
                fontSize: 12,
                fontWeight: FontWeight.normal,
                fontFamily: 'Cairo'),
            icon: const Icon( IonIcons.add_circle,size: 30,),
            title: " اضافة ",
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
          navBarDecoration: NavBarDecoration(
            
           color: Colors.white,
            borderRadius: BorderRadius.circular(0),
            
          ),
          navBarConfig: navBarConfig,
        ),
      );
}
