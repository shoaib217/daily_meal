import 'dart:math';

import 'package:daily_meal/dummy_data.dart';
import 'package:flutter/material.dart';

class MealDetailScreen extends StatefulWidget {
  Function favMeal;
  Function setFavorite;

  MealDetailScreen(this.favMeal, this.setFavorite);

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildSnackBar(String text){
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text),duration: Duration(seconds: 2),));

}

  Widget isFaviorates(String mealId) {
    if (widget.favMeal(mealId)) {
      return IconButton(
          onPressed: () {
            buildSnackBar('Meal Removed From Favorites!');
            setState(() {
              widget.setFavorite(false, mealId);
            });
          },
          icon: const Icon(
            Icons.star,
            color: Colors.yellow,
          ));
    } else {
      return IconButton(
          onPressed: () {
            buildSnackBar('Meal Added To Favorites!');
            setState(() {
              widget.setFavorite(true, mealId);
            });
          },
          icon: const Icon(
            Icons.star_border,
          ));
    }
  }

  Widget buildTitle(BuildContext context, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        value,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
        actions: [
          isFaviorates(mealId),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300,
              width: double.infinity,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.network(selectedMeal.imageUrl),
              ),
            ),
            buildTitle(context, 'Ingredients'),
            SizedBox(
              height: 200,
              width: 300,
              child: ListView.builder(
                itemBuilder: ((context, index) => Card(
                      color: Theme.of(context).colorScheme.secondary,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(selectedMeal.ingredients[index]),
                      ),
                    )),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildTitle(context, 'Steps'),
            Container(
              color: Theme.of(context).colorScheme.secondary,
              height: 200,
              width: 300,
              child: ListView.builder(
                itemBuilder: ((context, index) => Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Text('#${index + 1}'),
                          ),
                          title: Card(
                            color: Theme.of(context).colorScheme.secondary,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(selectedMeal.steps[index]),
                            ),
                          ),
                        ),
                        const Divider(thickness: 2.5),
                      ],
                    )),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.of(context).pop(mealId);
        },
        child: const Icon(Icons.delete),
      ),
    );
  }
}
