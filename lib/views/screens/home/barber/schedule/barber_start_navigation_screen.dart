import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_text_styles.dart';

class BarberStartNavigationScreen extends StatefulWidget {
  final Map<String, dynamic> appointment;

  const BarberStartNavigationScreen({super.key, required this.appointment});

  @override
  State<BarberStartNavigationScreen> createState() =>
      _BarberStartNavigationScreenState();
}

class _BarberStartNavigationScreenState
    extends State<BarberStartNavigationScreen> {
  final MapController _mapController = MapController();

  // ── Mock coordinates (production এ appointment থেকে নেবে) ──
  final LatLng _barberLocation = const LatLng(23.8103, 90.4125); // Dhaka
  final LatLng _customerLocation = const LatLng(23.8203, 90.4225);

  @override
  Widget build(BuildContext context) {
    final apt = widget.appointment;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // ── Map Section ──
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  // ── Flutter Map ──
                  FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: LatLng(
                        (_barberLocation.latitude + _customerLocation.latitude) / 2,
                        (_barberLocation.longitude + _customerLocation.longitude) / 2,
                      ),
                      initialZoom: 14,
                    ),
                    children: [
                      // ── Tile Layer (OpenStreetMap) ──
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app_bloom',
                      ),

                      // ── Route Line ──
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: [_barberLocation, _customerLocation],
                            color: Colors.orange,
                            strokeWidth: 4,
                          ),
                        ],
                      ),

                      // ── Markers ──
                      MarkerLayer(
                        markers: [
                          // Barber location
                          Marker(
                            point: _barberLocation,
                            width: 40.r,
                            height: 40.r,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.orange,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.content_cut,
                                  color: Colors.white, size: 20.r),
                            ),
                          ),
                          // Customer location
                          Marker(
                            point: _customerLocation,
                            width: 40.r,
                            height: 40.r,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.location_on,
                                  color: Colors.white, size: 20.r),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // ── Back Button ──
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                              padding: EdgeInsets.all(8.r),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: Icon(Icons.arrow_back_ios_new,
                                  size: 16.r, color: AppColors.textBlack),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            'Start Navigation',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ── ETA Card ──
                  Positioned(
                    top: 80.h,
                    left: 16.w,
                    right: 16.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.navigation, color: Colors.orange, size: 20.r),
                          SizedBox(width: 8.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ETA', style: TextStyle(fontSize: 10.sp, color: Colors.grey)),
                              Text('5 minutes',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textBlack)),
                            ],
                          ),
                          SizedBox(width: 24.w),
                          Container(width: 1, height: 30.h, color: Colors.grey.shade200),
                          SizedBox(width: 24.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Distance', style: TextStyle(fontSize: 10.sp, color: Colors.grey)),
                              Text(apt['distance'] ?? '1.2 km',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textBlack)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ── Direction Banner ──
                  Positioned(
                    bottom: 12.h,
                    left: 16.w,
                    right: 16.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(Icons.turn_right_outlined,
                                color: Colors.orange, size: 20.r),
                          ),
                          SizedBox(width: 12.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Turn right on Main Street',
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textBlack)),
                              Text('In 200 meter',
                                  style: TextStyle(fontSize: 11.sp, color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textBlack,
                              ),
                            ),
                            Text(
                              'First Time Customer',
                              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    // ── Message Button ──
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        'Message',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // ── Job Details ──
                    Text(
                      'Job Details',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textBlack,
                      ),
                    ),
                    SizedBox(height: 10.h),

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F8F8),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        children: [
                          _jobDetailRow(
                            color: Colors.orange,
                            icon: Icons.content_cut,
                            label: 'Service',
                            value: apt['service'] ?? "Men's Haircut",
                            note: '30 minutes • ${apt['price'] ?? '\$25.00'}',
                          ),
                          SizedBox(height: 12.h),
                          _jobDetailRow(
                            color: Colors.blue,
                            icon: Icons.access_time,
                            label: 'Scheduled Time',
                            value: apt['time'] ?? 'Today, 2:00 PM',
                            note: '',
                          ),
                          SizedBox(height: 12.h),
                          _jobDetailRow(
                            color: Colors.green,
                            icon: Icons.location_on_outlined,
                            label: 'Destination',
                            value: apt['address'] ?? '123 Main Street',
                            note: apt['addressNote'] ?? 'Downtown, Apartment 4B',
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // ── Special Instructions ──
                    if (apt['instructions'] != null &&
                        apt['instructions'].toString().isNotEmpty)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(14.w),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.orange.shade200),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.info_outline,
                                color: Colors.orange, size: 18.r),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Special Instructions',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.orange.shade800,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    apt['instructions'],
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.orange.shade700,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    SizedBox(height: 24.h),

                    // ── I've Arrived Button ──
                    GestureDetector(
                      onTap: () {
                        // TODO: Mark as arrived
                        Get.back();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          "I've Arrived",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _jobDetailRow({
    required Color color,
    required IconData icon,
    required String label,
    required String value,
    required String note,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36.r,
          height: 36.r,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, size: 18.r, color: color),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(fontSize: 11.sp, color: Colors.grey)),
            Text(value,
                style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textBlack)),
            if (note.isNotEmpty)
              Text(note,
                  style: TextStyle(fontSize: 11.sp, color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}