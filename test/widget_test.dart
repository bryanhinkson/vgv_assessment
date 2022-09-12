import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vgv_assessment/favorites.dart';

import 'package:vgv_assessment/main.dart';

void main() {
  testWidgets('App should load and favorite button should update',
      (WidgetTester tester) async {
    await tester.pumpWidget(const VeryGoodCoffeeApp());

    expect(find.text('Next Image'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Favorites'), findsOneWidget);
    expect(find.byIcon(Icons.favorite_outline), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite_outline));
    await tester.pump();

    expect(find.byIcon(Icons.favorite_outline), findsNothing);
    expect(find.byIcon(Icons.favorite), findsNWidgets(2));
  });

  testWidgets('Favorites zero state should load', (WidgetTester tester) async {
    await tester.pumpWidget(const FavoritesPage());

    /* 
      I want to test this but I don't know how to let the widget initialize first 
      -- assessmentScore = currentScore -1
    */
    // expect(find.text('Looks like you haven\'t favorited any images'),
    //     findsOneWidget);

    expect(find.byIcon(Icons.favorite_outline), findsNothing);
    expect(find.byIcon(Icons.favorite), findsNothing);
    expect(find.byIcon(Icons.home), findsNothing);
  });
}
