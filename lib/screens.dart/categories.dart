import 'package:flutter/material.dart';
import 'package:todo_app/data/dummy_data.dart';
import 'package:todo_app/model/category.dart';
import 'package:todo_app/screens.dart/meals.dart';
import 'package:todo_app/widgets/category_grid_items.dart';
import '../model/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.availableMeals});
  final List<Meal> availableMeals;

  void _categoriesScreen(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return MealsScreen(
            title: category.title,
            meals: filteredMeals,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.5 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              onTap: () {
                _categoriesScreen(context, category);
              },
              category: category,
            ),
        ],
      ),
    );
  }
}
