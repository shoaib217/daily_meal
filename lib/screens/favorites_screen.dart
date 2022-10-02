import 'package:daily_meal/models/meal.dart';
import 'package:flutter/material.dart';
import '../widgets/meal.dart';

class FavoritesScreen extends StatelessWidget {
final List<Meal> _favoriteMeals;

FavoritesScreen(this._favoriteMeals);

  @override
  Widget build(BuildContext context) {

    if(_favoriteMeals.isEmpty){
    return Center(child:Text('you have no favoriteMeal yet...') ,);
    }else{
      return ListView.builder(
        itemBuilder: ((context, index) {
          return MealItem(
            id: _favoriteMeals[index].id,
            title: _favoriteMeals[index].title,
            imageUrl: _favoriteMeals[index].imageUrl,
            duration: _favoriteMeals[index].duration,
            complexity: _favoriteMeals[index].complexity,
            affordability: _favoriteMeals[index].affordability,
          );
        }),
        itemCount: _favoriteMeals.length,
      );
    }
  }
}