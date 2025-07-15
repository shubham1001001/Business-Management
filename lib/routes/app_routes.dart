import 'package:flutter/material.dart';
import 'package:sales/screens/otp_screen/otp_screen.dart';

import '../screens/account_summary/account_summary_screen.dart';
import '../screens/add_staf/add_staf_screen.dart';
import '../screens/change_number/change_number_otp.dart';
import '../screens/change_number/mobile_number_change.dart';
import '../screens/email_change_screen/email_change_screen.dart';
import '../screens/email_change_screen/email_change_screen_otp.dart';
import '../screens/get_start/get_start_screen.dart';
import '../screens/navigation_wrapper/navigation_wrapper.dart';
import '../screens/record/record_screen.dart';
import '../screens/report/report_screen.dart';
import '../screens/signup/signup_screen.dart';
import '../screens/vehicle_overview/vehicle_overview_screen.dart';
import '../screens/vender_details/vender_detail_screen.dart';
import '../screens/vender_list/vender_list_screen.dart';
import 'app_routes_name.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final String? phoneNumber = settings.arguments as String?;
    switch (settings.name) {
      case AppRoutesName.getStart:
        return MaterialPageRoute(builder: (_) => GetStartScreen());
      case AppRoutesName.optScreen:
        return MaterialPageRoute(builder: (_) => OtpScreen());
      case AppRoutesName.home:
        return MaterialPageRoute(builder: (_) => NavigationWrapper());
      case AppRoutesName.record:
        return MaterialPageRoute(builder: (_) => RecordScreen());
      case AppRoutesName.report:
        return MaterialPageRoute(builder: (_) => const ReportScreen());
      case AppRoutesName.signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case AppRoutesName.mobileNumberChangeScreen:
        return MaterialPageRoute(builder: (_) => MobileNumberChange());
      case AppRoutesName.changeNumberOtpscreen:
        return MaterialPageRoute(builder: (_) => ChangeNumberOtp(number: phoneNumber ?? ''));
      case AppRoutesName.emaiChangeScreen:
        return MaterialPageRoute(builder: (_) => EmailChangeScreen());
      case AppRoutesName.emailChangeScreenOtp:
        return MaterialPageRoute(builder: (_) => EmailChangeScreenOtp(number: phoneNumber ?? ''));
      case AppRoutesName.venderDetailScreen:
        return MaterialPageRoute(builder: (_) => VenderDetailScreen());
      case AppRoutesName.addStaffScreen:
        return MaterialPageRoute(builder: (_) => AddStaffScreen());
      case AppRoutesName.vehicleOverviewScreen:
        return MaterialPageRoute(builder: (_) => VehicleOverviewScreen());
      case AppRoutesName.venderListScreen:
        return MaterialPageRoute(builder: (_) => VenderListScreen());
      case AppRoutesName.accountSummaryScreen:
        return MaterialPageRoute(builder: (_) => AccountSummaryScreen());
      default:
        return MaterialPageRoute(builder: (_) => NavigationWrapper());
    }
  }
}
