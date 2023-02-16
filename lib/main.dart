// ignore_for_file: unused_import, prefer_final_fields, no_leading_underscores_for_local_identifiers, empty_statements, dead_code, prefer_const_constructors

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import '../screens/category_meal_screen.dart';
import '../screens/filters_screen.dart';
import '../screens/meal_dettail_screen.dart';
import '../screens/tab_screen.dart';
import 'dummy_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegen': false,





    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoritesMeals = [];





  void _setfilters(Map<String, bool> _filtersData) {
    setState(() {
      _filters = _filtersData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && (!meal.isGlutenFree)) {
          return false;
        }
        ;
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        ;
        if (_filters['vegen']! && !meal.isVegan) {
          return false;
        }
        ;
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        ;
        return true;
        ;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId) {
    final existingIndex =
        _favoritesMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoritesMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoritesMeals
            .add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoritesMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          canvasColor: Color.fromARGB(255, 255, 250, 229),
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1:
                    const TextStyle(color: Color.fromRGBO(20, 50, 50, 1)),
                subtitle1: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
              ),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
              .copyWith(secondary: Colors.amber)),
      // home: MyHomePage(),
      routes: {
        // '/': (context) => CategoriesScreen(),
        '/': (context) => TabScreen(_favoritesMeals),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(_toggleFavourite, _isMealFavorite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_setfilters, _filters)
      },
    );
  }
}
