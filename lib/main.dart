import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/providers/auth_provider/email_provider/email_provider.dart';
import 'package:sales/providers/auth_provider/number_change_provider/change_number_provider.dart';
import 'package:sales/providers/auth_provider/signup_provider.dart';
import 'package:sales/providers/generate_provider/generate_provider.dart';
import 'package:sales/providers/home_provider/home_provider.dart';
import 'package:sales/providers/home_provider/home_tabprovider.dart';
import 'package:sales/providers/nav_provider.dart';
import 'package:sales/providers/otp_provider/CountdownProvider.dart';
import 'package:sales/providers/record_provider.dart';
import 'package:sales/providers/support_provider/support_provider.dart';
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
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => SupportProvider()),
        ChangeNotifierProvider(create: (_) => GenerateProvider()),
        ChangeNotifierProvider(create: (_) => ChangeNumberProvider()),
        ChangeNotifierProvider(create: (_) => EmailProvider()),
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
        appBarTheme: const AppBarTheme(backgroundColor: AppColors.primary, foregroundColor: AppColors.appBackColor),
      ),
      initialRoute: AppRoutesName.home,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
