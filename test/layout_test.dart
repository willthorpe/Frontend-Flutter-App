// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_app/views/calendar/create.dart';
import 'package:flutter_app/views/calendar/edit.dart';
import 'package:flutter_app/views/calendar/index.dart';
import 'package:flutter_app/views/home.dart';
import 'package:flutter_app/views/authentication/login.dart';
import 'package:flutter_app/views/authentication/register.dart';
import 'package:flutter_app/views/ingredient/list.dart';
import 'package:flutter_app/views/recipe/create.dart';
import 'package:flutter_app/views/settings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/views/ingredient/index.dart';
import 'package:flutter_app/views/recipe/index.dart';

void main() {

  //Test home page
  testWidgets('Home Page ', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(title: 'Your Recipes')
      )
    );
    expect(find.text('Your Recipes'), findsOneWidget);
    expect(find.byType(GridView), findsNWidgets(1));
    expect(find.descendant(of: find.byType(GridView), matching: find.byType(RaisedButton)), findsNWidgets(8));
  });

  //Test register page
  testWidgets('Register Page ', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(
            home: RegisterPage(title: 'Register')
        )
    );
    expect(find.text('Register'), findsNWidgets(2));
    expect(find.text('Email'), findsNWidgets(1));
    expect(find.text('Password'), findsNWidgets(1));
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(RaisedButton), findsNWidgets(2));
  });

  //Test login page
  testWidgets('Login Page ', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(
            home: LoginPage(title: 'Login')
        )
    );
    expect(find.text('Login'), findsNWidgets(2));
    expect(find.text('Email'), findsNWidgets(1));
    expect(find.text('Password'), findsNWidgets(1));
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(RaisedButton), findsNWidgets(3));
  });

  //Test ingredient create page
  testWidgets('Ingredient List Page ', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(
            home: ListIngredientPage(title: 'List Ingredient')
        )
    );
    expect(find.text('List Ingredient'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Amount'), findsOneWidget);
    expect(find.text('Measurement'), findsOneWidget);
    expect(find.text('Storage Location'), findsOneWidget);
    expect(find.byType(Form), findsNWidgets(1));
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.byType(ListTile), findsNWidgets(4));
    expect(find.byType(RaisedButton), findsNWidgets(1));
  });

  //Test ingredient create page
  testWidgets('Recipe Create Page ', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(
            home: CreateRecipePage(title: 'Create Recipe')
        )
    );
    expect(find.text('Create Recipe'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Meal Time'), findsOneWidget);
    expect(find.text('Servings'), findsOneWidget);
    expect(find.text('Preparation Time'), findsOneWidget);
    expect(find.text('Cooking Time'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(4));
    expect(find.byType(RaisedButton), findsNWidgets(2));
  });

  //Test ingredient view page
  testWidgets('Larder Page ', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(
            home: IngredientsPage(title: 'Larder')
        )
    );
    expect(find.text('Larder'), findsOneWidget);
    expect(find.text('Enter ingredient to search'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  //Test recipe view page
  testWidgets('Recipe Book ', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(
            home: BookPage(title: 'Recipe Book')
        )
    );
    expect(find.text('Recipe Book'), findsOneWidget);
    expect(find.text('Enter recipe to search'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  //Test calendar view page
  testWidgets('Calendar View Page ', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(
            home: CalendarsPage(title: 'Recipe Calendars')
        )
    );
    expect(find.text('Recipe Calendars'), findsOneWidget);
    expect(find.byType(ListView), findsNWidgets(1));
    expect(find.descendant(of: find.byType(ListView), matching: find.byType(RaisedButton)), findsNWidgets(4));
  });

  //Test Create Calendar page
  testWidgets('Create Calendar Page ', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(
            home: CreateCalendarPage(title: 'Create Calendar')
        )
    );
    expect(find.text('Create Calendar'), findsOneWidget);
    expect(find.text('Monday'), findsOneWidget);
    expect(find.text('Tuesday'), findsOneWidget);
    expect(find.text('Wednesday'), findsOneWidget);
    expect(find.text('Thursday'), findsOneWidget);
    expect(find.text('Friday'), findsOneWidget);
    expect(find.text('Saturday'), findsOneWidget);
    expect(find.text('Sunday'), findsOneWidget);

    expect(find.byType(CircularProgressIndicator), findsNWidgets(7));
    expect(find.byType(RaisedButton), findsNWidgets(2));
  });

  //Test Edit Calendar page
  testWidgets('Edit Calendar Page ', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(
            home: EditCalendarPage(title: 'Edit Calendar')
        )
    );
    expect(find.text('Edit Calendar'), findsOneWidget);
    expect(find.text('Monday'), findsOneWidget);
    expect(find.text('Tuesday'), findsOneWidget);
    expect(find.text('Wednesday'), findsOneWidget);
    expect(find.text('Thursday'), findsOneWidget);
    expect(find.text('Friday'), findsOneWidget);
    expect(find.text('Saturday'), findsOneWidget);
    expect(find.text('Sunday'), findsOneWidget);

    expect(find.byType(CircularProgressIndicator), findsNWidgets(7));
    expect(find.byType(RaisedButton), findsNWidgets(2));
  });
}
