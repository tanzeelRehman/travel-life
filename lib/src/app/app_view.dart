import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/configs/app_setup.locator.dart';
import 'package:starter_app/src/services/local/connectivity_service.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

class AppView extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          AppColors.appDarkBlue, //TODO: this was transparent before.
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));
    return ScreenUtilInit(
      designSize: Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, snapshot) {
        return MaterialApp(
          title: Constants.appTitle,
          debugShowCheckedModeBanner: false,
          navigatorKey: NavService.key,
          onGenerateRoute: NavService.onGenerateRoute,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.appDarkBlue,
            useMaterial3: true,
            colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: AppColors.appDarkBlue,
              onPrimary: AppColors.white,
              secondary: AppColors.appFaddedBlue,
              onSecondary: AppColors.white,
              error: AppColors.red,
              onError: AppColors.white,
              background: AppColors.white,
              onBackground: AppColors.appDarkBlue,
              surface: AppColors.white,
              onSurface: AppColors.appDarkBlue,
            ),
            fontFamily: 'Poppins',
          ),
          builder: (context, child) {
            final connectivityService = locator<ConnectivityService>();
            return connectivityService.isInternetConnected
                ? Stack(
                    children: [child!],
                  )
                : NoInternet();
          },
        );
      },
    );
  }
}

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.screenSize().width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 250.h,
              width: 250.h,
              child: Image.asset(
                AssetImages.logo,
                width: context.screenSize().width * 0.8,
                height: context.screenSize().width * 0.8,
              ),
            ),
            VerticalSpacing(15),
            Column(
              children: [
                Text(
                  "No Internet Connection found, check your connection or try again.",
                  style: TextStyling.bold.copyWith(
                    color: AppColors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
