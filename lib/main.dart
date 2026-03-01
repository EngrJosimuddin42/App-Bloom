import 'package:app_bloom/views/screens/home_page/barber/barber_home_screen.dart';
import 'package:app_bloom/views/screens/home_page/barber/barber_required_Info_screen.dart';
import 'package:app_bloom/views/screens/sign_up/sign_up_screen.dart';
import 'package:app_bloom/views/screens/sign_up/sign_up_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'services/api_service.dart';
import 'themes/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(ApiService(), permanent: true);

  runApp(const BarberCallApp());
}

class BarberCallApp extends StatelessWidget {
  const BarberCallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'BarberCall',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.background,
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
            useMaterial3: true,
          ),
          home: const BarberRequiredInfoScreen(),
        );
      },
    );
  }
}