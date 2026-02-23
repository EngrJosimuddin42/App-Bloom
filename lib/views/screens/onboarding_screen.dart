import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../services/local_storage_service.dart';
import '../../../themes/app_colors.dart';
import '../../utils/constants/onboarding_data.dart';
import '../base/onboarding_content.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < onboardingPages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _onGetStarted();
    }
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _skipToEnd() {
    _pageController.animateToPage(
      onboardingPages.length - 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _onGetStarted() async {
    await LocalStorageService.setOnboardingCompleted();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = _currentPage == onboardingPages.length - 1;

    return Scaffold(
      backgroundColor: AppColors.textPrimary,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Navigation Bar ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage > 0)
                    GestureDetector(
                      onTap: _previousPage,
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_ios,
                              color: Colors.black, size: 16.sp),
                          SizedBox(width: 4.w),
                          Text(
                            'Back',
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    const SizedBox(width: 60),

                  if (!isLastPage)
                    GestureDetector(
                      onTap: _skipToEnd,
                      child: Text(
                        'Skip',
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  else
                    const SizedBox(width: 40),
                ],
              ),
            ),

            // ── Page Content ──
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingPages.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  return OnboardingPageView(data: onboardingPages[index]);
                },
              ),
            ),

            // ── Page Indicators ──
            Padding(
              padding: EdgeInsets.only(bottom: 24.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingPages.length,
                      (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    width: _currentPage == index ? 28.w : 6.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Colors.black
                          : const Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
              ),
            ),

            // ── Bottom Button ──
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 32.h),
              child: SizedBox(
                width: 358.w,
                height: 48.h,
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xFF2B2B2B), Color(0xFF000000)],
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: InkWell(
                      onTap: _nextPage,
                      borderRadius: BorderRadius.circular(8.r),
                      child: Center(
                        child: Text(
                          isLastPage ? 'Get Started' : 'Next',
                          style: GoogleFonts.montserrat(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}