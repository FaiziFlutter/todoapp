import 'package:flutter/material.dart';
import 'package:todo_app/data/dummy_data.dart';
import 'package:todo_app/model/meal.dart';
import 'package:todo_app/screens.dart/categories.dart';
import 'package:todo_app/screens.dart/filter.dart';
import 'package:todo_app/screens.dart/meals.dart';
import 'package:todo_app/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int activePageIndex = 0;
  final List<Meal> _favouritesMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

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

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            currentFilters: _selectedFilters,
          ),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    var title = 'Categories';
    Widget activeScreen = CategoriesScreen(
      onPressed: _onToggleFavouriteMeal,
      availableMeals: availableMeals,
    );

    if (activePageIndex == 1) {
      activeScreen = MealsScreen(
          meals: _favouritesMeals, onPressed: _onToggleFavouriteMeal);
      title = 'Favourites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: MainDrawer(
        onTap: _setScreen,
      ),
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
