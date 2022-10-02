import 'package:daily_meal/models/meal.dart';
import 'package:daily_meal/widgets/meal.dart';
import 'package:flutter/material.dart';

class CategoryMealScreen extends StatefulWidget {
List<Meal> availableMeals;

CategoryMealScreen(this.availableMeals);


  @override
  State<CategoryMealScreen> createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String categoryTitle;
  List<Meal> displayItem;

  @override
  void didChangeDependencies() {
    final routeArg =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    final categoryId = routeArg['id'];
    categoryTitle = routeArg['title'];
    displayItem = widget.availableMeals.where(((meal) {
      return meal.categories.contains(categoryId);
    })).toList();
    super.didChangeDependencies();
  }

  Function _removeMeal(String mealId) {
      print(mealId);
      setState(() {
        displayItem.removeWhere((element) => element.id == mealId);
      });
    }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: ((context, index) {
          return MealItem(
            id: displayItem[index].id,
            title: displayItem[index].title,
            imageUrl: displayItem[index].imageUrl,
            duration: displayItem[index].duration,
            complexity: displayItem[index].complexity,
            affordability: displayItem[index].affordability,
            removeMeal: _removeMeal,
          );
        }),
        itemCount: displayItem.length,
      ),
    );
  }
}
