import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_styles.dart';

class PersonalBookingScreen extends StatefulWidget {
  const PersonalBookingScreen({super.key});

  @override
  State<PersonalBookingScreen> createState() => _PersonalBookingScreenState();
}

class _PersonalBookingScreenState extends State<PersonalBookingScreen> {
  DateTime selectedDate = DateTime(2024, 6, 10);
  TimeOfDay selectedTime = const TimeOfDay(hour: 9, minute: 41);

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) setState(() => selectedTime = picked);
  }

  String _formatDate(DateTime d) {
    const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return '${months[d.month - 1]} ${d.day}, ${d.year}';
  }

  String _formatTime(TimeOfDay t) {
    final hour = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final minute = t.minute.toString().padLeft(2, '0');
    final period = t.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.backgroundBlack1,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundBlack1,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
            onPressed: () => Get.back(),
          ),
          title: Text(
            'Personal',
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ── Barber Card ──
                    _BarberCard(),

                    SizedBox(height: 24.h),

                    // ── Selected Services ──
                    _SectionHeader(icon: Icons.content_cut, title: 'Selected Services'),
                    SizedBox(height: 12.h),
                    _ServiceTile(),

                    SizedBox(height: 24.h),

                    // ── Select Date & Time ──
                    _SectionHeader(icon: Icons.calendar_today_outlined, title: 'Select Date & Time'),
                    SizedBox(height: 12.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          // Date
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Date',
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.textBlack2,
                                    fontSize: 11.sp,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                GestureDetector(
                                  onTap: _pickDate,
                                  child: Row(
                                    children: [
                                      Icon(Icons.calendar_today_outlined,
                                          size: 14.sp, color: AppColors.textBlack),
                                      SizedBox(width: 6.w),
                                      Text(
                                        _formatDate(selectedDate),
                                        style: AppTextStyles.bodySmall.copyWith(
                                          color: AppColors.textBlack,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(width: 1, height: 36.h, color: Colors.grey.shade300),
                          SizedBox(width: 14.w),

                          // Time
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Time',
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.textBlack2,
                                    fontSize: 11.sp,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                GestureDetector(
                                  onTap: _pickTime,
                                  child: Row(
                                    children: [
                                      Icon(Icons.access_time_outlined,
                                          size: 14.sp, color: AppColors.textBlack),
                                      SizedBox(width: 6.w),
                                      Text(
                                        _formatTime(selectedTime),
                                        style: AppTextStyles.bodySmall.copyWith(
                                          color: AppColors.textBlack,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // ── Service Location ──
                    _SectionHeader(icon: Icons.location_on_outlined, title: 'Service Location'),
                    SizedBox(height: 12.h),

                    // Address tile
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '123 Main Street',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.textBlack,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'Downtown, Apartment 4B, New York, NY',
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.textBlack2,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.chevron_right, color: AppColors.textBlack2),
                        ],
                      ),
                    ),

                    SizedBox(height: 10.h),

                    // Add new address
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          '+ Add new address',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textBlack2,
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 8.h),
                  ],
                ),
              ),
            ),

            // ── Total + Proceed ──
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textBlack2,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        'R350',
                        style: AppTextStyles.sectionTitle.copyWith(
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.w700,
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: navigate to payment
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.textBlack,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        elevation: 0,
                      ),
                      child: Text(
                        'Proceed to payment',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Barber Card ──
class _BarberCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26.r,
            backgroundImage: const NetworkImage('https://i.pravatar.cc/150?img=12'),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Marcus Johnson',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textBlack,
                  fontWeight: FontWeight.w700,
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Master Barber',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textBlack2,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Service Tile ──
class _ServiceTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          // Service image placeholder
          Container(
            width: 44.w,
            height: 44.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.content_cut, color: Colors.grey.shade500, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Men's Haircut",
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '30 minutes',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textBlack2,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'R350',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textBlack,
              fontWeight: FontWeight.w700,
              fontSize: 15.sp,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Section Header ──
class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  const _SectionHeader({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20.sp, color: AppColors.textBlack),
        SizedBox(width: 8.w),
        Text(
          title,
          style: AppTextStyles.sectionTitle.copyWith(
            color: AppColors.textBlack,
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}