import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../model/meal.dart';
import 'meal_item_trait.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onTap,
  });

  final Meal meal;
  final void Function(Meal meal) onTap;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Card(
      margin: EdgeInsets.all(width * 0.01),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(width * 0.04),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onTap(meal);
        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: height * 0.3,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: EdgeInsets.symmetric(
                    vertical: width * 0.035, horizontal: height * 0.01),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis, // Very long text ...
                      style: TextStyle(
                        fontSize: width * 0.055,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        SizedBox(width: width * 0.02),
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        SizedBox(width: width * 0.02),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
