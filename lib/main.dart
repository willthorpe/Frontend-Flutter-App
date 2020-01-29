import 'package:flutter/material.dart';
import 'views/home.dart';
import 'views/create_ingredient.dart';
import 'views/create_recipe.dart';
import 'views/search.dart';
import 'views/login.dart';
import 'views/register.dart';
import 'views/stockroom.dart';
import 'views/book.dart';
import 'views/calendar.dart';
import 'views/detail_recipe.dart';
import 'views/shopping_list.dart';
import 'views/settings.dart';
import 'database/open.dart';

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
        '/addingredient' : (context) => IngredientPage(title: 'Add Ingredient'),
        '/addrecipe' : (context) => RecipePage(title: 'Add Recipe'),
        '/search' : (context) => SearchPage(title: 'Recipe Search'),
        '/stockroom' : (context) => StockroomPage(title: 'View Ingredients'),
        '/recipebook' : (context) => BookPage(title: 'Recipe Book'),
        '/recipecalendar' : (context) => CalendarPage(title:'Recipe Calendar'),
        '/recipedetail' : (context) => RecipeDetailPage(),
        '/shoppinglist' : (context) => ShoppingListPage(title: 'Shopping List'),
        '/settings' : (context) => SettingsPage(title: 'Settings'),

      },
    );
  }
}