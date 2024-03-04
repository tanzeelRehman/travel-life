import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/styles/app_colors.dart';

class AppView extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
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
            return Stack(
              children: [child!],
            );
          },
        );
      },
    );
  }
}
