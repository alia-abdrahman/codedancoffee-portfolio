import 'package:flutter_test/flutter_test.dart';

import 'package:codedancoffee_portfolio/main.dart';

void main() {
  testWidgets('PortfolioApp builds without crashing', (tester) async {
    await tester.pumpWidget(const PortfolioApp());
  });
}
