import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/customer/customer_home_controller.dart';
import '../../themes/app_colors.dart';
import 'custom_button.dart';
import 'eta_card.dart';
import 'location_info_card.dart';
import 'navigation_map.dart';

class CustomerMapSection extends StatelessWidget {
  final CustomerHomeController controller;
  const CustomerMapSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final mapController = MapController();

    return SizedBox(
      height: 300.h,
      child: Obx(() {
        // ── Loading State ──
        if (controller.isLoading) {
          return Container(
            color: const Color(0xFFE8E8E8),
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        return Stack(
          children: [
            // ── Flutter Map ──
            ClipRRect(
              borderRadius: BorderRadius.zero,
              child: NavigationMap(
                mapController: mapController,
                barberLocation: controller.barberLocation,
                customerLocation: controller.customerLocation,
              ),
            ),

            // ── ETA Card ──
            Positioned(
              top: 20.h,
              left: 70.w,
              right: 70.w,
              child: EtaCard(
                eta: controller.eta,
                distance: controller.distance,
              ),
            ),

            // ── Location + Nearby Card ──
            Positioned(
              bottom: 12.h,
              left: 12,
              child: LocationInfoCard(
                location: controller.locationName,
                barbersNearby: controller.barbersNearby,
              ),
            ),

            // ── Request Barber Button ──
            Positioned(
              bottom: 20.h,
              left: 220.w,
              right: 20.w,
              child: CustomButton(
                label: 'Request Barber',
                onTap: controller.requestBarber,
                gradient: AppColors.splashGradient,
                height: 40.h,
                borderRadius: 8,
              ),
            ),
          ],
        );
      }),
    );
  }
}