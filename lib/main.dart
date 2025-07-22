import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/providers/account_details/account_details_provider.dart';
import 'package:sales/providers/account_overview/account_overview_provider.dart';
import 'package:sales/providers/account_summary_provider/account_summary_provider.dart';
import 'package:sales/providers/add_account/add_account_provider.dart';
import 'package:sales/providers/add_item_provider/add_item_proivder.dart';
import 'package:sales/providers/add_purchase/add_purchase_provider.dart';
import 'package:sales/providers/add_staf/add_staf_provider.dart';
import 'package:sales/providers/add_transportation/add_transportation_provider.dart';
import 'package:sales/providers/add_vehicle/add_vehicle_provider.dart';
import 'package:sales/providers/auth_provider/email_provider/email_provider.dart';
import 'package:sales/providers/auth_provider/number_change_provider/change_number_provider.dart';
import 'package:sales/providers/auth_provider/signup_provider.dart';
import 'package:sales/providers/expense_details/expense_details_provider.dart';
import 'package:sales/providers/generate_provider/generate_provider.dart';
import 'package:sales/providers/home_provider/home_provider.dart';
import 'package:sales/providers/home_provider/home_tab_provider.dart';
import 'package:sales/providers/item_create/item_create_provider.dart';
import 'package:sales/providers/item_list_provider/item_list_provider.dart';
import 'package:sales/providers/nav_provider.dart';
import 'package:sales/providers/otp_provider/countdown_provider.dart';
import 'package:sales/providers/pricing_preference/pricing_preference_provider.dart';
import 'package:sales/providers/profile_information_provider/profile_information_provider.dart';
import 'package:sales/providers/purchase_bill_overview/purchase_bill_overview_provider.dart';
import 'package:sales/providers/record_provider.dart';
import 'package:sales/providers/set_distance/set_distance_provider.dart';
import 'package:sales/providers/subscription_plan_provider/Subscription_plan_provider.dart';
import 'package:sales/providers/support_provider/support_provider.dart';
import 'package:sales/providers/tab_provider/tab_provider.dart';
import 'package:sales/providers/trip_provider/trip_provider.dart';
import 'package:sales/providers/vehicle_overview_provider.dart';
import 'package:sales/providers/vender_list_provider/vender_list_provider.dart';
import 'package:sales/providers/vendor_comment_timeline/vendor_comment_timeline_provider.dart';
import 'package:sales/routes/app_routes_name.dart';

import 'core/constants/colors.dart';
import 'providers/sales_order_provider.dart';
import 'routes/app_routes.dart';

void main() {
  print("main start");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SalesOrderProvider()),
        ChangeNotifierProvider(create: (_) => RecordProvider()),
        ChangeNotifierProvider(create: (_) => NavProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CountdownProvider()),
        ChangeNotifierProvider(create: (_) => TabProvider()),
        ChangeNotifierProvider(create: (_) => TabProviderHome()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => SupportProvider()),
        ChangeNotifierProvider(create: (_) => GenerateProvider()),
        ChangeNotifierProvider(create: (_) => ChangeNumberProvider()),
        ChangeNotifierProvider(create: (_) => EmailProvider()),
        ChangeNotifierProvider(create: (_) => ProfileInformationProvider()),
        ChangeNotifierProvider(create: (_) => SubscriptionPlanProvider()),
        ChangeNotifierProvider(create: (_) => TripProvider()),
        ChangeNotifierProvider(create: (_) => PurchaseBillOverviewProvider()),
        ChangeNotifierProvider(create: (_) => AddStafProvider()),
        ChangeNotifierProvider(create: (_) => VehicleOverviewProvider()),
        ChangeNotifierProvider(create: (_) => VenderListProvider()),
        ChangeNotifierProvider(create: (_) => ItemListProvider()),
        ChangeNotifierProvider(create: (_) => AddItemProvider()),
        ChangeNotifierProvider(create: (_) => AccountSummaryProvider()),
        ChangeNotifierProvider(create: (_) => AddAccountProvider()),
        ChangeNotifierProvider(create: (_) => AccountOverviewProvider()),
        ChangeNotifierProvider(create: (_) => AccountDetailsProvider()),
        ChangeNotifierProvider(create: (_) => ItemCreateProvider()),
        ChangeNotifierProvider(create: (_) => PricingPreferenceProvider()),
        ChangeNotifierProvider(create: (_) => AddVehicleProvider()),
        ChangeNotifierProvider(create: (_) => VendorCommentTimelineProvider()),
        ChangeNotifierProvider(create: (_) => ExpenseDetailProvider()),
        ChangeNotifierProvider(create: (_) => AddTransportationProvider()),
        ChangeNotifierProvider(create: (_) => AddPurchaseProvider()),
        ChangeNotifierProvider(create: (_) => SetDistanceProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sales Order App',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.accent, primary: AppColors.primary),
        appBarTheme: const AppBarTheme(backgroundColor: AppColors.primary, foregroundColor: AppColors.appBlackColor),
      ),
      initialRoute: AppRoutesName.getStart,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
