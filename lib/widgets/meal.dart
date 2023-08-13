import 'package:daily_meal/models/meal.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  Function removeMeal;

  MealItem(
       this.removeMeal,{Key? key, required this.id,
      required this.title,
      required this.imageUrl,
      required this.duration,
      required this.complexity,
      required this.affordability,
      }) : super(key: key);

  String get complexityText {
    /* var text = '';
    if(complexity == Complexity.Challenging){
      text = 'Challenging';
    }else if(complexity == Complexity.Hard){
      text = 'Hard';
    }else if(complexity == Complexity.Simple){
      text = 'Simple';
    }
    return text; */
    switch (complexity) {
      case Complexity.Simple:
        return 'Simple';
        break;
      case Complexity.Challenging:
        return 'Challenging';
        break;
      case Complexity.Hard:
        return 'Hard';
        break;
      default:
        return 'Unknown';
    }
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.Affordable:
        return 'Affordable';
        break;
      case Affordability.Pricey:
        return 'Pricey';
        break;
      case Affordability.Luxurious:
        return 'Luxurious';
        break;
      default:
        return 'Unknown';
    }
  }

  void selectMeal(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(MyApp.mealDetailScreen,
        arguments: id).then((value) {
          if(value!=null){
            removeMeal(value);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() => selectMeal(context)),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(
                      right: 10, left: 10, top: 5, bottom: 5),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 26, color: Colors.black),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                Image.network(
                  imageUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  color: Theme.of(context).cardColor,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const Icon(Icons.schedule),
                          const SizedBox(
                            width: 5,
                          ),
                          Text('$duration Min'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const Icon(Icons.work),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(complexityText),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const Icon(Icons.attach_money_outlined),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(affordabilityText),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
