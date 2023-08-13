import 'package:daily_meal/dummy_data.dart';
import 'package:daily_meal/models/filter.dart';
import 'package:daily_meal/models/meal.dart';

import './screens/FilterScreen.dart';
import 'package:daily_meal/screens/category_meal_screen.dart';
import 'package:daily_meal/screens/meal_detail_screen.dart';
import 'package:flutter/material.dart';
import './screens/tab_screen.dart';
import 'screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  static const String categoriesScreen = '/category_meal';
  static const String mealDetailScreen = '/meal_detail';
  static const String FilterScreens = '/filter';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _filter = Filter(false, false, false, false);
  bool isFavorite = false;
  List<String> favoriteMealId =[];
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];



  bool checkFavorite(String mealId) {
    print(mealId);
    if (favoriteMealId.contains(mealId)) {
      return true;
    } else {
      return false;
    }
  }

  void setFavorite(bool isFaviorates, String mealId) {
    setState(() {
      if (isFaviorates) {
        favoriteMealId.add(mealId);
        isFavorite = true;
        _favoriteMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      }
      if (isFaviorates == false) {
        favoriteMealId.remove(mealId);
        _favoriteMeals
            .remove(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
        isFavorite = false;
      }
    });
    print(isFaviorates);
    print(mealId);
  }

  void _setFilters(Filter filterData) {
    setState(() {
      _filter = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filter.gluten && !meal.isGlutenFree) {
          return false;
        }
        if (_filter.vegan && !meal.isVegan) {
          return false;
        }
        if (_filter.vegetarian && !meal.isVegetarian) {
          return false;
        }
        if (_filter.lactose && !meal.isLactoseFree) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Meal',
      theme: ThemeData(
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyLarge: const TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyMedium: const TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            titleMedium: const TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
            .copyWith(secondary: Colors.amber),
      ),
      home: TabsScreen(_favoriteMeals),
      routes: {
        MyApp.categoriesScreen: (context) =>
            CategoryMealScreen(_availableMeals),
        MyApp.mealDetailScreen: (context) =>
            MealDetailScreen(checkFavorite, setFavorite),
        MyApp.FilterScreens: (context) => FilterScreen(_filter, _setFilters),
      },
    );
  }
}
