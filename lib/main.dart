import 'package:flutter/material.dart';
import 'package:flutter_app/views/home.dart';
import 'package:flutter_app/database/open.dart';

//Authentication Imports
import 'package:flutter_app/views/authentication/login.dart';
import 'package:flutter_app/views/authentication/register.dart';

//Ingredient Imports
import 'package:flutter_app/views/ingredient/index.dart';
import 'package:flutter_app/views/ingredient/list.dart';
import 'package:flutter_app/views/ingredient/edit.dart';

//Recipe Imports
import 'package:flutter_app/views/recipe/index.dart';
import 'package:flutter_app/views/recipe/create.dart';
import 'package:flutter_app/views/recipe/next.dart';
import 'package:flutter_app/views/recipe/view.dart';

//Search Imports
import 'package:flutter_app/views/search/index.dart';
import 'package:flutter_app/views/search/results.dart';
import 'package:flutter_app/views/settings.dart';

//Calendar Imports
import 'package:flutter_app/views/calendar/index.dart';
import 'package:flutter_app/views/calendar/create.dart';
import 'package:flutter_app/views/calendar/edit.dart';
import 'package:flutter_app/views/calendar/view.dart';
import 'package:flutter_app/views/calendar/automate.dart';
import 'package:flutter_app/views/calendar/results.dart';

//Other Views
import 'package:flutter_app/views/shoppingList/index.dart';
import 'package:flutter_app/views/nutrition.dart';
import 'package:flutter_app/views/graphs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    setupDatabase();
    return MaterialApp(
      title: 'Meal Planner',
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
        primaryColor: Colors.orange[300],
      ),
      initialRoute: '/',
      routes: {
        '/home' : (context) => HomePage(title: 'Your Recipes'),
        '/register' : (context) => RegisterPage(title: 'Register'),
        '/' : (context) => LoginPage(title: 'Login'),
        '/listingredient' : (context) => ListIngredientPage(title: 'List Ingredient'),
        '/editingredient' : (context) => EditIngredientPage(),
        '/createrecipe' : (context) => CreateRecipePage(title: 'Create Recipe'),
        '/createcalendar' : (context) => CreateCalendarPage(title:'Create Calendar'),
        '/editcalendar' : (context) => EditCalendarPage(title:'Edit Calendar'),
        '/viewcalendars' : (context) => ViewCalendarsPage(title:'View Calendars'),
        '/automatecalendar': (context) => AutomateCalendarPage(title: 'Automate Calendar'),
        '/automateresults': (context) => AutomateResultsPage(),
        '/nextrecipe' : (context) => NextRecipePage(title:'Next Recipe'),
        '/nutritiongoals' : (context) => CreateNutritionPage(title: 'Nutrition Goals'),
        '/search' : (context) => SearchPage(title: 'Recipe Search'),
        '/searchresults' : (context) => SearchResultsPage(),
        '/larder' : (context) => IngredientsPage(title: 'Larder'),
        '/recipebook' : (context) => BookPage(title: 'Recipe Book'),
        '/recipecalendar' : (context) => CalendarsPage(title:'Recipe Calendars'),
        '/recipeview' : (context) => ViewRecipePage(),
        '/shoppinglist' : (context) => ShoppingListPage(title: 'Shopping List'),
        '/graphs' : (context) => GraphsPage(title: 'Graphs'),
        '/settings' : (context) => SettingsPage(title: 'Settings'),
      },
    );
  }
}