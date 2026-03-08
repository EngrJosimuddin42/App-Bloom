import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_styles.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  static const List<Map<String, dynamic>> _transactions = [
    {
      'title': "Men's Haircut - Marcus Johnson",
      'date': 'Today, 2:15 PM',
      'amount': '-\$35',
      'isCredit': false,
      'status': 'completed',
    },
    {
      'title': 'Wallet Top-up',
      'date': 'Feb 2, 10:30 AM',
      'amount': '+\$100',
      'isCredit': true,
      'status': 'completed',
    },
    {
      'title': 'Hair + Beard - Alex Rodriguez',
      'date': 'Jan 28, 4:45 PM',
      'amount': '-\$50',
      'isCredit': false,
      'status': 'completed',
    },
    {
      'title': 'Wallet Top-up',
      'date': 'Jan 25, 9:00 AM',
      'amount': '+\$150',
      'isCredit': true,
      'status': 'completed',
    },
    {
      'title': 'Premium Haircut - James Carter',
      'date': 'Jan 20, 1:30 PM',
      'amount': '-\$40',
      'isCredit': false,
      'status': 'completed',
    },
  ];

  void _showAddFundsDialog({required bool isCrypto}) {
    final amountController = TextEditingController();
    Get.dialog(
      Dialog(
        backgroundColor: const Color(0xFF1A1A2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Title ──
              Text(
                isCrypto ? 'Add Crypto Funds' : 'Add Fiat Funds',
                style: AppTextStyles.sectionTitle.copyWith(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 14.h),

              // ── Label ──
              Text(
                'Amount (ZAR)',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),

              // ── Input ──
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                style: AppTextStyles.bodySmall.copyWith(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Enter Amount',
                  hintStyle: AppTextStyles.caption.copyWith(
                    color: Colors.white38,
                    fontSize: 13.sp,
                  ),
                  filled: true,
                  fillColor: const Color(0xFF2A2A3E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 14.h,
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // ── Buttons ──
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 13.h),
                      ),
                      child: Text(
                        'Cancel',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        // TODO: process payment
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.textBlack,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 13.h),
                        elevation: 0,
                      ),
                      child: Text(
                        'Payment',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
            'Wallet',
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── Two Balance Cards ──
              Row(
                children: [
                  // ── Fiat ──
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1565C0),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('R Fiat Balance',
                                  style: AppTextStyles.caption.copyWith(
                                      color: Colors.white70, fontSize: 11.sp)),
                              _Badge(label: 'USD'),
                            ],
                          ),
                          SizedBox(height: 6.h),
                          Text('R0.00',
                              style: AppTextStyles.sectionTitle.copyWith(
                                  color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w700)),
                          SizedBox(height: 2.h),
                          Text('Available to spend',
                              style: AppTextStyles.caption.copyWith(
                                  color: Colors.white60, fontSize: 11.sp)),
                          SizedBox(height: 12.h),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => _showAddFundsDialog(isCrypto: false),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade300,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r)),
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                elevation: 0,
                              ),
                              child: Text('+ Add Funds',
                                  style: AppTextStyles.caption.copyWith(
                                      color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12.sp)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: 12.w),

                  // ── Crypto ──
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF5D4037),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('₿ Crypto Balance',
                                  style: AppTextStyles.caption.copyWith(
                                      color: Colors.white70, fontSize: 11.sp)),
                              _Badge(label: 'USDC'),
                            ],
                          ),
                          SizedBox(height: 6.h),
                          Text('R0.00',
                              style: AppTextStyles.sectionTitle.copyWith(
                                  color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w700)),
                          SizedBox(height: 2.h),
                          Text('Crypto holdings',
                              style: AppTextStyles.caption.copyWith(
                                  color: Colors.white60, fontSize: 11.sp)),
                          SizedBox(height: 12.h),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => _showAddFundsDialog(isCrypto: true),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange.shade600,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r)),
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                elevation: 0,
                              ),
                              child: Text('+ Add Crypto',
                                  style: AppTextStyles.caption.copyWith(
                                      color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12.sp)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              // ── Total Balance ──
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    Text('Balance',
                        style: AppTextStyles.caption.copyWith(
                            color: AppColors.textBlack2, fontSize: 12.sp)),
                    SizedBox(height: 4.h),
                    Text('R0.00',
                        style: AppTextStyles.sectionTitle.copyWith(
                            color: AppColors.textBlack, fontSize: 18.sp, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // ── Recent Transactions ──
              Text('Recent Transactions',
                  style: AppTextStyles.sectionTitle.copyWith(
                      color: AppColors.textBlack, fontSize: 18.sp, fontWeight: FontWeight.w700)),
              SizedBox(height: 12.h),

              Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: _transactions.isEmpty
                    ? const _EmptyTransactions()
                    : Column(
                  children: _transactions.asMap().entries.map((e) {
                    final i = e.key;
                    final tx = e.value;
                    return Column(
                      children: [
                        _TransactionTile(
                          title: tx['title'],
                          date: tx['date'],
                          amount: tx['amount'],
                          isCredit: tx['isCredit'],
                          status: tx['status'],
                        ),
                        if (i < _transactions.length - 1)
                          Divider(height: 1, color: Colors.grey.shade100,
                              indent: 16.w, endIndent: 16.w),
                      ],
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Badge ──
class _Badge extends StatelessWidget {
  final String label;
  const _Badge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(label,
          style: AppTextStyles.caption.copyWith(
              color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.w600)),
    );
  }
}

// ── Empty Transactions ──
class _EmptyTransactions extends StatelessWidget {
  const _EmptyTransactions();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.h),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.receipt_long_outlined, size: 40.sp, color: Colors.grey.shade400),
            SizedBox(height: 12.h),
            Text('No transaction yet',
                style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textBlack2, fontSize: 13.sp)),
          ],
        ),
      ),
    );
  }
}

// ── Transaction Tile ──
class _TransactionTile extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final bool isCredit;
  final String status;

  const _TransactionTile({
    required this.title,
    required this.date,
    required this.amount,
    required this.isCredit,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          Container(
            width: 38.w,
            height: 38.h,
            decoration: BoxDecoration(
              color: isCredit ? Colors.green.shade50 : Colors.red.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCredit ? Icons.arrow_downward : Icons.arrow_upward,
              size: 18.sp,
              color: isCredit ? Colors.green : Colors.red,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textBlack, fontWeight: FontWeight.w500, fontSize: 13.sp)),
                SizedBox(height: 2.h),
                Text(date,
                    style: AppTextStyles.caption.copyWith(
                        color: AppColors.textBlack2, fontSize: 11.sp)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount,
                  style: AppTextStyles.bodySmall.copyWith(
                      color: isCredit ? Colors.green : AppColors.textBlack,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp)),
              SizedBox(height: 2.h),
              Text(status,
                  style: AppTextStyles.caption.copyWith(
                      color: Colors.green, fontSize: 11.sp)),
            ],
          ),
        ],
      ),
    );
  }
}