import 'package:flutter/material.dart';
import '../../models/onboarding_model.dart';

const List<OnboardingModel> onboardingPages = [
  OnboardingModel(
    icon: Icons.content_cut_outlined,
    title: 'On-Demand Barbers',
    description: 'Request a professional barber anytime, anywhere',
  ),
  OnboardingModel(
    icon: Icons.location_on_outlined,
    title: 'Live Tracking',
    description: 'Track your barber in real-time as they arrive',
  ),
  OnboardingModel(
    icon: Icons.account_balance_wallet_outlined,
    title: 'Multi-Currency Wallet',
    description: 'Pay with fiat or cryptocurrency seamlessly',
  ),
  OnboardingModel(
    icon: Icons.bolt_outlined,
    title: 'Instant Service',
    description: 'Get groomed at your location within minutes',
  ),
];