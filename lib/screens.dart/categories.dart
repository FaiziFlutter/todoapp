import 'package:flutter/material.dart';
import 'package:todo_app/data/dummy_data.dart';
import 'package:todo_app/model/category.dart';
import 'package:todo_app/screens.dart/meals.dart';
import 'package:todo_app/widgets/category_grid_items.dart';
import '../model/meal.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});
  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  void _categoriesScreen(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
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
    //final height = MediaQuery.of(context).size.height;
    return Scaffold(
      /*  
      //////Explicit Animation//////
      Here we are doing the explicit animation.
      Animation where we make all the animations by ourselves.
       */
      body: AnimatedBuilder(
        animation: _animationController,
        // builder: (context, child) => Padding(
        //     padding: EdgeInsets.only(
        //         top: height * 1 - _animationController.value * height * 1),
        //     child: child),

        child: GridView(
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
        builder: (context, child) => SlideTransition(
          position: Tween(begin: const Offset(0, 0.3), end: const Offset(0, 0))
              .animate(CurvedAnimation(
                  parent: _animationController, curve: Curves.easeInOut)),
          child: child,
        ),
      ),
    );
  }
}
