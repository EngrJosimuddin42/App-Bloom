import 'package:app_bloom/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';

class NavigationMap extends StatelessWidget {
  final MapController mapController;
  final LatLng barberLocation;
  final LatLng customerLocation;

  const NavigationMap({
    super.key,
    required this.mapController,
    required this.barberLocation,
    required this.customerLocation,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: LatLng(
          (barberLocation.latitude + customerLocation.latitude) / 2,
          (barberLocation.longitude + customerLocation.longitude) / 2,
        ),
        initialZoom: 14,
      ),
      children: [
        // ── Tile Layer ──
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app_bloom',
        ),

        // ── Route Line ──
        PolylineLayer(
          polylines: [
            Polyline(
              points: [barberLocation, customerLocation],
              color: AppColors.backgroundOrange,
              strokeWidth: 4,
            ),
          ],
        ),

        // ── Markers ──
        MarkerLayer(
          markers: [
            Marker(
              point: barberLocation,
              width: 40.r,
              height: 40.r,
              child: Container(
                decoration:BoxDecoration(
                  color: AppColors.secondary1,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: ImageIcon(
                    AssetImage('assets/images/noto_scissors.png'),
                    color: AppColors.textRed,
                    size: 20.r,
                  ),
                ),
              ),
            ),
            Marker(
              point: customerLocation,
              width: 40.r,
              height: 40.r,
              child: Container(
                decoration:BoxDecoration(
                  color: AppColors.textOrange2,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: ImageIcon(
                    AssetImage('assets/images/user1.png'),
                    color: AppColors.textBlack,
                    size: 20.r,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}