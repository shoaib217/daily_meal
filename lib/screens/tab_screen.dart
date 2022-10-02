import 'dart:ui';

import 'package:daily_meal/models/meal.dart';
import 'package:daily_meal/widgets/main_drawer.dart';

import './categories_screen.dart';
import './favorites_screen.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
List<Meal> favoriteMeals;

TabsScreen(this.favoriteMeals);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
List<Map<String,Object>> _pages;

@override
  void initState() {
    _pages = [
  {
    'page':  CategoriesScreen(),
    'title': 'Categories',
  },
  {
    'page':  FavoritesScreen(widget.favoriteMeals),
    'title': 'Favorite Meal',
  },
];
    super.initState();
  }

int _selectedPageIndex = 0;

void _selectPage(int index){
  setState(() {
    _selectedPageIndex = index;
  });
}

  @override
  Widget build(BuildContext context) {
    var favoriteMeal = widget.favoriteMeals;
Future<bool> _onBackPressed() async {
        return await showDialog(
            context: context, builder: (context) => AlertDialog(
  title: Text('Are Sure You Want To Exit?', textScaleFactor: 1),
  actions: <Widget>[
    TextButton(child: Text('Yes'), onPressed: () {Navigator.of(context).pop(true);}),
    TextButton(child: Text('No'), onPressed: () {Navigator.of(context).pop(false);}),
  ],
)
);
      }
    return WillPopScope(onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectedPageIndex]['title']),
        ),
        drawer: MainDrawer(),
        body: _pages[_selectedPageIndex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          currentIndex: _selectedPageIndex,
          // type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              label: 'Categories',
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.category),
            ),
            BottomNavigationBarItem(
              label: 'Favorites',
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.star),
            ),
          ],
        ),
      ),
    );
  }
}
