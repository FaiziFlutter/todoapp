import 'package:flutter/material.dart';
import 'package:todo_app/model/meal.dart';
import 'package:todo_app/screens.dart/categories.dart';
import 'package:todo_app/screens.dart/meals.dart';
import 'package:todo_app/widgets/main_drawer.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int activePageIndex = 0;
  final List<Meal> _favouritesMeals = [];

  void _message(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }

  _onToggleFavouriteMeal(Meal meal) {
    final isExisting = _favouritesMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favouritesMeals.remove(meal);
      });
      _message('Meal is no longer favourite. ');
    } else {
      setState(() {
        _favouritesMeals.add(meal);
      });
      _message('Marked as a favourite!');
    }
  }

  void _selectPage(int index) {
    setState(() {
      activePageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = CategoriesScreen(onPressed: _onToggleFavouriteMeal);
    var title = 'Categories';
    if (activePageIndex == 1) {
      activeScreen = MealsScreen(
          meals: _favouritesMeals, onPressed: _onToggleFavouriteMeal);
      title = 'Favourites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: const MainDrawer(),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: activePageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites'),
        ],
      ),
    );
  }
}
