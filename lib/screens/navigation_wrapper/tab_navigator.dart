import 'package:flutter/material.dart';

import '../home_screen/home_screen.dart';
import '../more/more_screen.dart';
import '../record/record_screen.dart';
import '../report/report_screen.dart';
import '../sales/sales_order_overview_screen.dart';

class TabNavigator extends StatelessWidget {
  final String tabName;
  final GlobalKey<NavigatorState> navigatorKey;

  const TabNavigator({super.key, required this.tabName, required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    Widget rootScreen;
    switch (tabName) {
      case 'Home':
        rootScreen = const HomeScreen();
        break;
      case 'Report':
        rootScreen = const ReportScreen();
        break;
      case 'Record':
        rootScreen = SalesOrderOverviewScreen();
        break;
      case 'Generate':
        rootScreen = SizedBox();

        break;
      case 'More':
        rootScreen = const MoreScreen();
        break;
      default:
        rootScreen = const Scaffold();
    }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (settings) {
        WidgetBuilder builder;

        switch (settings.name) {
          case '/':
            builder = (_) => rootScreen;
            break;
          case '/details':
            builder = (_) => RecordScreen();
            break;
          default:
            builder = (_) => const Scaffold(body: Text("Page not found"));
        }

        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
