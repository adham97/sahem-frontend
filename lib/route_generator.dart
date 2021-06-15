import 'package:flutter/material.dart';

import 'src/models/route_argument.dart';
import 'src/pages/notifications.dart';
import 'src/pages/splash.dart';
import 'src/pages/login.dart';
import 'src/pages/register.dart';
import 'src/pages/second_register.dart';
import 'src/pages/forget_password.dart';
import 'src/pages/pages.dart';
import 'src/pages/profile.dart';
import 'src/pages/setting.dart';
import 'src/pages/language.dart';
import 'src/pages/platform.dart';
import 'src/pages/platform_details.dart';
import 'src/pages/user_role.dart';
import 'src/pages/assistance_request.dart';
import 'src/pages/cash_support.dart';
import 'src/pages/material_support.dart';
import 'src/pages/assistance_response.dart';
import 'src/elements/NewCard.dart';
import 'src/elements/NewDonation.dart';
import 'src/pages/donation_store_details.dart';
import 'src/pages/driver.dart';
import 'src/elements/FullScreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/Register':
        return MaterialPageRoute(builder: (_) => RegisterWidget());
      case '/SecondRegister':
        return MaterialPageRoute(builder: (_) => SecondRegisterWidget());
      case '/Login':
        return MaterialPageRoute(builder: (_) => LoginWidget());
      case '/ForgetPassword':
        return MaterialPageRoute(builder: (_) => ForgetPasswordWidget());
      case '/Pages':
        return MaterialPageRoute(builder: (_) => PagesWidget(currentTab: args));
      case '/Profile':
        return MaterialPageRoute(builder: (_) => ProfileWidget());
      case '/Setting':
        return MaterialPageRoute(builder: (_) => SettingWidget());
      case '/Languages':
        return MaterialPageRoute(builder: (_) => LanguagesWidget());
      case '/Platform':
        return MaterialPageRoute(builder: (_) => PlatformWidget(routeArgument: args as RouteArgument));
      case '/PlatformDetails':
        return MaterialPageRoute(builder: (_) => PlatformDetailsWidget(routeArgument: args as RouteArgument));
      case '/UserRole':
        return MaterialPageRoute(builder: (_) => UserRoleWidget(routeArgument: args as RouteArgument));
      case '/HelpRequest':
        return MaterialPageRoute(builder: (_) => AssistanceRequestWidget());
      case '/Notifications':
        return MaterialPageRoute(builder: (_) => NotificationsWidget());
      case '/CashSupport':
        return MaterialPageRoute(builder: (_) => CashSupport(routeArgument: args as RouteArgument));
      case '/MaterialSupport':
        return MaterialPageRoute(builder: (_) => MaterialSupport(routeArgument: args as RouteArgument));
      case '/AssistanceResponse':
        return MaterialPageRoute(builder: (_) => AssistanceResponseWidget(assistance: args));
      case '/NewCard':
        return MaterialPageRoute(builder: (_) => NewCardWidget());
      case '/AddDonation':
        return MaterialPageRoute(builder: (_) => NewDonation());
      case '/DonationStoreDetails':
        return MaterialPageRoute(builder: (_) => DonationStoreDetails(donationStore: args));
      case '/Driver':
        return MaterialPageRoute(builder: (_) => DriverWidget());
      case '/FullScreen':
        return MaterialPageRoute(builder: (_) => FullScreenPage(image: args));
      default:
        return MaterialPageRoute(builder: (_) => Scaffold(
          body: SafeArea(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Route Error',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xffce2029),
                ),
              )
            )
          )
        ));
    }
  }
}
