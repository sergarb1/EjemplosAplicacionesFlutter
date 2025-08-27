import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:juego_memoria/providers/game_provider.dart';
import 'package:juego_memoria/widgets/card_widget.dart';

void main() {
  testWidgets('CardWidget displays correctly and flips', (WidgetTester tester) async {
    final provider = GameProvider();
    await provider.initGame(4, 4);

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: provider,
        child: MaterialApp(
          home: Scaffold(body: CardWidget(index: 0)),
        ),
      ),
    );

    expect(find.byIcon(Icons.question_mark), findsOneWidget);

    provider.flipCard(0);
    await tester.pumpAndSettle();

    expect(find.byType(Image), findsOneWidget);
  });
}