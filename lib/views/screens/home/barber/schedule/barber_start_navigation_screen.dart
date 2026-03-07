import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../../../../../controllers/barber/barber_home_controller.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../base/custom_button.dart';
import '../../../../base/direction_banner.dart';
import '../../../../base/eta_card.dart';
import '../../../../base/job_detail_row.dart';
import '../../../../base/navigation_map.dart';
import '../../../../base/special_instructions_card.dart';

class BarberStartNavigationScreen extends StatefulWidget {
  const BarberStartNavigationScreen({super.key});

  @override
  State<BarberStartNavigationScreen> createState() =>
      _BarberStartNavigationScreenState();
}

class _BarberStartNavigationScreenState
    extends State<BarberStartNavigationScreen> {
  final MapController _mapController = MapController();
  late final BarberHomeController _c;

  @override
  void initState() {
    super.initState();
    _c = Get.find<BarberHomeController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final apt            = _c.navAppointment;
      final barberLocation = LatLng(_c.navBarberLat, _c.navBarberLng);
      final customerLocation = LatLng(_c.navCustomerLat, _c.navCustomerLng);

      return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: AppColors.backgroundBlack1,
            statusBarIconBrightness: Brightness.light,
          ),
          child: Scaffold(
              backgroundColor: AppColors.backgroundBlack1,
              body: SafeArea(
                  top: true,
                  child: Column(
                    children: [
                    // ── Status bar extended area ──
                    Container(
                    height: 10.h,
                    color: AppColors.backgroundBlack1,
                  ),

                  // ── Main Content ──
                  Expanded(
                    child: ColoredBox(
                      color: Colors.white,
          child: Column(
            children: [
              // ── Back Button ──
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.w, vertical: 8.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Icon(Icons.arrow_back_ios_new,
                            size: 18.r, color: AppColors.textBlack),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'Start Navigation',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Map Section ──
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Stack(
                  children: [
                    // ── Flutter Map ──
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child:
                    NavigationMap(
                      mapController: _mapController,
                      barberLocation: barberLocation,
                      customerLocation: customerLocation,
                    ),
                ),



                    // ── ETA Card ──
                    Positioned(
                      top: 20.h,
                      left: 70.w,
                      right: 70.w,
                      child: EtaCard(
                        eta: _c.navEta,
                        distance: _c.navDistance,
                      ),
                    ),

                    // ── Direction Banner ──
                    Positioned(
                      bottom: 12.h,
                      left: 40.w,
                      right: 40.w,
                      child: DirectionBanner(
                        direction: _c.navDirection,
                        directionNote: _c.navDirectionNote,
                      ),
                    ),
                  ],
                ),
              ),
              ),

              // ── Bottom Info Section ──
              Expanded(
                flex: 6,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),

                      // ── Customer Info ──
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                apt['name'] ?? 'Customer',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textBlack,
                                ),
                              ),
                              Text(
                                'First Time Customer',
                                style: TextStyle(
                                    fontSize: 12.sp, color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 12.h),

                      // ── Message Button ──
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: AppColors.textBlack),
                        ),
                        child: Text(
                          'Message',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textBlack,
                          ),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // ── Job Details ──
                      Text(
                        'Job Details',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textBlack,
                        ),
                      ),
                      SizedBox(height: 10.h),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(14.w),
                        decoration: BoxDecoration(
                          color: AppColors.cardColor,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: AppColors.textSecondary)
                        ),
                        child: Column(
                          children: [
                            JobDetailRow(
                              color: AppColors.purple1,
                              iconPath: 'assets/images/bx_cut.png',
                              label: 'Service',
                              value: apt['service'] ?? "Men's Haircut",
                              note:
                              '30 minutes • ${apt['price'] ?? '\$25.00'}',
                            ),
                            SizedBox(height: 12.h),
                            JobDetailRow(
                              color: AppColors.backgroundBlue,
                              iconPath: 'assets/images/time1.png',
                              label: 'Scheduled Time',
                              value: apt['time'] ?? 'Today, 2:00 PM',
                              note: '',
                            ),
                            SizedBox(height: 12.h),
                            JobDetailRow(
                              color: Colors.green,
                              iconPath: 'assets/images/location1.png',
                              label: 'Destination',
                              value: apt['address'] ?? '123 Main Street',
                              note: apt['addressNote'] ??
                                  'Downtown, Apartment 4B',
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 12.h),

                      // ── Special Instructions ──
                      if (apt['instructions'] != null &&
                          apt['instructions'].toString().isNotEmpty)
                        SpecialInstructionsCard(
                          instructions: apt['instructions'],
                        ),

                      SizedBox(height: 24.h),

                      // ── I've Arrived Button ──
                      CustomButton(
                        label: "I've Arrived",
                        height: 52.h,
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xFF00A63E),Color(0xFF00C950)],
                        ),
                        onTap: () {
                          Get.back();
                        },
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
                  ),
                ],
                  ),
              ),
          ),
      );
    });
  }
}