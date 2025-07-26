import 'package:flutter/material.dart';
import 'package:sales/routes/app_routes_name.dart';
import 'package:sales/screens/profile_Informations/profile_informations.dart';

import '../add_item/add_item_screen.dart';
import '../add_purchase/add_purchase_screen.dart';
import '../add_transportation/add_transportation_screen.dart';
import '../expense_details/expense_details_screen.dart';
import '../home_screen/home_screen.dart';
import '../item_list/item_list_screen.dart';
import '../more/more_screen.dart';
import '../purchase_bill_overview/purchase_bill_overview.dart';
import '../record/record_screen.dart';
import '../report/report_screen.dart';
import '../sales/sales_order_overview_screen.dart';
import '../subscriptions_plan/subscriptions_plan_screen.dart';
import '../trip_summary/trip_summary_screen.dart';
import '../vehicle_overview/vehicle_overview_screen.dart';
import '../vender_details/vender_detail_screen.dart';
import '../vender_list/vender_list_screen.dart';

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
        rootScreen = RecordScreen();
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
            builder = (_) => SalesOrderOverviewScreen();
            break;
          case AppRoutesName.ProfileInformations:
            builder = (_) => ProfileInformations();
            break;
          case AppRoutesName.subscriptionPlanScreen:
            builder = (_) => SubscriptionPlanScreen();
            break;
          case AppRoutesName.venderDetailScreen:
            builder = (_) => VenderDetailScreen();
            break;
          case AppRoutesName.tripSummaryScreen:
            builder = (_) => TripSummaryScreen();
            break;
          case AppRoutesName.purchaseBillOverviewScreen:
            builder = (_) => PurchaseBillOverviewScreen();
          case AppRoutesName.venderListScreen:
            builder = (_) => VenderListScreen();
            break;
          case AppRoutesName.itemListScreen:
            builder = (_) => ItemListScreen();
            break;
          case AppRoutesName.addItemScreen:
            builder = (_) => AddItemScreen();
            break;
          case AppRoutesName.expenseDetailsScreen:
            builder = (_) => ExpenseDetailsScreen();
            break;
          case AppRoutesName.addTransportationScreen:
            builder = (_) => AddTransportationScreen();
            break;
          case AppRoutesName.addPurchaseScreen:
            builder = (_) => AddPurchaseScreen();
            break;
          case '/vehicleOverviewScreen':
            builder = (_) => VehicleOverviewScreen();
            break;
          default:
            builder = (_) => const Scaffold(body: Text("Page not found"));
        }

        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
