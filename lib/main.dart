import 'package:flutter/material.dart';
import 'views/home.dart';
import 'views/login.dart';
import 'views/register.dart';
import 'views/settings.dart';
import 'views/shoppingList/index.dart';
import 'views/nutrition.dart';
import 'database/open.dart';

import 'views/ingredient/index.dart';
import 'views/ingredient/create.dart';

import 'views/recipe/index.dart';
import 'views/recipe/create.dart';
import 'views/recipe/next.dart';
import 'views/recipe/view.dart';

import 'views/search/index.dart';
import 'views/search/results.dart';

import 'views/calendar/index.dart';
import 'views/calendar/create.dart';
import 'views/calendar/edit.dart';
import 'views/calendar/view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    setupDatabase();
    return MaterialApp(
      title: 'Integrated Recipes',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      routes: {
        '/home' : (context) => HomePage(title: 'Your Recipes'),
        '/register' : (context) => RegisterPage(title: 'Register'),
        '/' : (context) => LoginPage(title: 'Login'),
        '/createingredient' : (context) => CreateIngredientPage(title: 'Create Ingredient'),
        '/createrecipe' : (context) => CreateRecipePage(title: 'Create Recipe'),
        '/createcalendar' : (context) => CreateCalendarPage(title:'Create Calendar'),
        '/editcalendar' : (context) => EditCalendarPage(title:'Edit Calendar'),
        '/viewcalendars' : (context) => ViewCalendarsPage(title:'View Calendars'),
        '/nextrecipe' : (context) => NextRecipePage(title:'Next Recipe'),
        '/nutritiongoals' : (context) => CreateNutritionPage(title: 'Nutrition Goals'),
        '/search' : (context) => SearchPage(title: 'Recipe Search'),
        '/searchresults' : (context) => SearchResultsPage(),
        '/ingredients' : (context) => IngredientsPage(title: 'Ingredients'),
        '/recipebook' : (context) => BookPage(title: 'Recipe Book'),
        '/recipecalendar' : (context) => CalendarsPage(title:'Recipe Calendars'),
        '/recipeview' : (context) => ViewRecipePage(),
        '/shoppinglist' : (context) => ShoppingListPage(title: 'Shopping List'),
        '/settings' : (context) => SettingsPage(title: 'Settings'),
      },
    );
  }
}