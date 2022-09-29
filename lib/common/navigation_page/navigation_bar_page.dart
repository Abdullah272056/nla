import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';


import '../static/Colors.dart';

import 'cart/card_page.dart';
import 'home_page.dart';
import 'money_option.dart';

class NavigationBarScreen extends StatefulWidget {
  final int _selectedTabIndex;
  //int _selectedPageIndex;
  Widget _selectedPage;


  NavigationBarScreen(this._selectedTabIndex, this._selectedPage);
  // NavigationBarScreen(this._selectedTabIndex, this._selectedPageIndex, {Key? key}) : super(key: key);

  @override
  _NavigationBarScreenState createState() => _NavigationBarScreenState(this._selectedTabIndex, this._selectedPage);

}

class _NavigationBarScreenState extends State<NavigationBarScreen> with SingleTickerProviderStateMixin{
  int _selectedTabIndex;
  Widget _selectedPage;
 // int _selectedPageIndex;


  _NavigationBarScreenState(this._selectedTabIndex, this._selectedPage);

  final navigationkey = GlobalKey<CurvedNavigationBarState>();

  // int _selectedTabIndex = 0;
  // int _selectedPageIndex = 0;
  final items1 = <Widget>[
    Image.asset("assets/images/Home.png",
        color: Colors.white,
        width: 25, height: 25,),
    Image.asset("assets/images/cycle.png",
        width: 25, height: 25, color: Colors.white),
    Image.asset("assets/images/blog_icon.png",
        width: 25, height: 25, color: Colors.white),
    Image.asset("assets/images/cart_icon.png",
        width: 25, height: 25, color: Colors.white),
    Image.asset("assets/images/profile_icon.png",
        width: 25, height: 25, color: Colors.white),

    // const Icon(Icons.person,size: 35,
    //   color: Colors.appRed,),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
     // _selectedPageIndex = index;
      _selectedPage=_widgetOptions.elementAt(index);
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    const HomePageScreen(),
    const HomePageScreen(),
    const MoneyOptionScreen(),
    const CardPageScreen(),
    const HomePageScreen(),
    // RoomDetailsScreen("1"),
    // CartPageScreen()
  ];


  late final TabController _tabcontroller;

  @override
  void initState() {
    super.initState();
    _tabcontroller = TabController(length: 5, vsync: this,initialIndex:_selectedTabIndex,);

    // _onItemTapped(_selectedTabIndex);

  }

  //
  // @override
  // @mustCallSuper
  // initState() {
  //   super.initState();
  //   setState(() {
  //     // Route route = MaterialPageRoute(builder: (context) => SplashScreen2());
  //     // Navigator.pushReplacement(context, route);
  //
  //
  //   });
  //
  //
  //
  // }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      //backgroundColor: Colors.intello_bd_color_dark,
      body:  Center(
        child: _selectedPage,
        // child: _widgetOptions.elementAt(_selectedPageIndex),
      ),

      bottomNavigationBar: Container(
        height: 60,


        decoration: BoxDecoration(
          color:Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.15),
              blurRadius: 20.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: const Offset(
                2.0, // Move to right 10  horizontally
                1.0, // Move to bottom 10 Vertically
              ),
            )
          ],
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15.0),
              bottomRight: Radius.circular(0.0),
              topLeft: Radius.circular(15.0),
              bottomLeft: Radius.circular(0.0)),
        ),

        child: TabBar(
          controller: _tabcontroller,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.green,
          indicatorWeight: 4,
          indicatorColor: novalexxa_color,
          onTap: (index) {
            _onItemTapped(index);
            // currentIndex: _selectedTabIndex,
            //   selectedItemColor: Colors.amber[800],
          },
          tabs: [
            Tab(
              icon:_tabcontroller.index == 0 ?
              Image.asset('assets/images/Home.png', height: 20, width: 20,fit: BoxFit.fill,color: Colors.black) :
              Image.asset('assets/images/Home.png', height: 20, width: 20,
                  fit: BoxFit.fill
              ),
            ),
            Tab(
              icon:_tabcontroller.index ==1 ?
              Image.asset('assets/images/cycle.png', height: 20, width: 20,color: Colors.black,fit: BoxFit.fill) :
              Image.asset('assets/images/cycle.png', height: 20, width: 20,fit: BoxFit.fill
              ),
            ),
            Tab(
              icon:_tabcontroller.index == 2 ?
              Image.asset('assets/images/send_money.png', height: 20, width: 20,color: Colors.black,fit: BoxFit.fill) :
              Image.asset('assets/images/send_money.png', height: 20, width: 20,fit: BoxFit.fill
              ),
            ),
            Tab(
              icon:_tabcontroller.index == 3 ?
              Image.asset('assets/images/icon_id.png', height: 16, width: 20,color: Colors.black,fit: BoxFit.fill) :
              Image.asset('assets/images/icon_id.png', height: 16, width: 20,fit: BoxFit.fill
              ),
            ),
            Tab(
              icon:_tabcontroller.index == 4 ?
              Image.asset('assets/images/others.png', height: 20, width: 20,color: Colors.black,fit: BoxFit.fill) :
              Image.asset('assets/images/others.png', height: 20, width: 20,fit: BoxFit.fill
              ),
            ),

          ],
        ),

      ),
    );
  }






}

