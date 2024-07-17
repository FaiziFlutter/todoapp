import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/providers/favourite_provider.dart';
import 'package:todo_app/screens.dart/categories.dart';
import 'package:todo_app/screens.dart/filter.dart';
import 'package:todo_app/screens.dart/meals.dart';
import 'package:todo_app/widgets/main_drawer.dart';

import '../providers/filter_provider.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int activePageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      activePageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    var title = 'Categories';
    Widget activeScreen = CategoriesScreen(
      availableMeals: availableMeals,
    );

    if (activePageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);

      activeScreen = MealsScreen(meals: favoriteMeals);
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
        selectedIconTheme: const IconThemeData(color: Colors.white),
        elevation: BorderSide.strokeAlignCenter,
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
