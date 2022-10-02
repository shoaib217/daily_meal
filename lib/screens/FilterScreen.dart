import 'package:daily_meal/main.dart';
import 'package:daily_meal/models/filter.dart';
import 'package:daily_meal/screens/tab_screen.dart';

import '../widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {

final Function saveFilter;
final Filter filter;

FilterScreen(this.filter,this.saveFilter);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Filter filter;

@override
  void initState() {
    filter = widget.filter;
    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(description),
        value: currentValue,
        onChanged: updateValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text('Your Filter'),
        actions: [IconButton(onPressed:() {
          widget.saveFilter(filter);
          Navigator.of(context).pushReplacementNamed('/');
        } , icon: Icon(Icons.save,color: Colors.white,))]
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust Your Meal Selection.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTile(
                'Glutten Free',
                'Only include gluten free Meal',
                filter.gluten,
                (value) {
                  setState(() {
                    filter.gluten = value;
                  });
                },
              ),
              _buildSwitchListTile(
                'Vegetarian',
                'Only include vegetarian Meal',
                filter.vegetarian,
                (value) {
                  setState(() {
                    filter.vegetarian = value;
                  });
                },
              ),
              _buildSwitchListTile(
                'vegan',
                'Only include vegan Meal',
                filter.vegan,
                (value) {
                  setState(() {
                    filter.vegan = value;
                  });
                },
              ),
              _buildSwitchListTile(
                'Lactose Free',
                'Only include lactose free Meal',
                filter.lactose,
                (value) {
                  setState(
                    () {
                      filter.lactose = value;
                    },
                  );
                },
              ),
            ],
          ))
        ],
      ),
    );
  }
}
