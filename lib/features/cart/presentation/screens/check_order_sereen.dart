import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/default_elevated_button.dart';


class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int currentStep = 0; // 0 = Shipping, 1 = Payment, 2 = Review
  int selectedAddressIndex = 0;
  int selectedPaymentIndex = 0;
  bool isOrderSummaryExpanded = false;

  final List<Map<String, dynamic>> addresses = [
    {
      'title': 'Home',
      'address': '123 Elegance Boulevard, Suite 405\nManhattan, NY 10013',
      'phone': '+1 (555) 012-3456',
      'icon': 'home',
    },
    {
      'title': 'Office',
      'address': '88 Fashion Avenue, Floor 12\nNew York, NY 10001',
      'phone': null,
      'icon': 'work',
    },
  ];

  final List<Map<String, dynamic>> paymentMethods = [
    {
      'title': 'CARD ENDING 4242',
      'icon': 'credit_card',
      'selected': true,
    },
    {
      'title': 'DIGITAL WALLET',
      'icon': 'wallet',
      'selected': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.backgroundDark : AppColors.backgroundWhite;
    final cardBgColor = isDark ? AppColors.black : AppColors.white;
    final textColor = isDark ? AppColors.white : AppColors.black;
    final subtitleColor = AppColors.darkGray;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Gang Store',
          style: textTheme.titleLarge?.copyWith(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_bag_outlined, color: textColor),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stepper
            _buildStepper(isDark),
            const SizedBox(height: 24),

            // Shipping Address Section
            _buildSectionHeader('Shipping Address', 'Add New', textTheme, textColor),
            const SizedBox(height: 12),

            ...List.generate(addresses.length, (index) {
              return _buildAddressCard(
                address: addresses[index],
                isSelected: selectedAddressIndex == index,
                onTap: () => setState(() => selectedAddressIndex = index),
                isDark: isDark,
                textTheme: textTheme,
                textColor: textColor,
                subtitleColor: subtitleColor,
              );
            }),

            const SizedBox(height: 24),

            // Payment Method Section
            Text(
              'Payment Method',
              style: textTheme.titleMedium?.copyWith(color: textColor),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _buildPaymentCard(
                    title: 'CARD ENDING 4242',
                    icon: Icons.credit_card,
                    isSelected: selectedPaymentIndex == 0,
                    onTap: () => setState(() => selectedPaymentIndex = 0),
                    isDark: isDark,
                    textTheme: textTheme,
                    textColor: textColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildPaymentCard(
                    title: 'DIGITAL WALLET',
                    icon: Icons.account_balance_wallet_outlined,
                    isSelected: selectedPaymentIndex == 1,
                    onTap: () => setState(() => selectedPaymentIndex = 1),
                    isDark: isDark,
                    textTheme: textTheme,
                    textColor: textColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Order Summary
            _buildOrderSummary(
              textTheme: textTheme,
              textColor: textColor,
              subtitleColor: subtitleColor,
              isDark: isDark,
            ),

            const SizedBox(height: 24),

            // Total Amount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TOTAL AMOUNT',
                      style: textTheme.titleSmall?.copyWith(
                        color: subtitleColor,
                        fontSize: 12,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$570.00',
                      style: textTheme.titleMedium?.copyWith(
                        color: textColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.verified_user_outlined, size: 16, color: AppColors.primary),
                    const SizedBox(width: 4),
                    Text(
                      'SECURE PAYMENT',
                      style: textTheme.titleSmall?.copyWith(
                        color: AppColors.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Place Order Button
            DefaultElevatedButton(
              label: 'Place Order',
              onPressed: () {},
              prefixSvgPath: 'assets/icons/arrow_right', // or null if no icon
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStepper(bool isDark) {
    final steps = ['SHIPPING', 'PAYMENT', 'REVIEW'];

    return Row(
      children: List.generate(steps.length * 2 - 1, (index) {
        if (index.isOdd) {
          // Connector line
          final stepIndex = index ~/ 2;
          final isActive = stepIndex < currentStep;
          return Expanded(
            child: Container(
              height: 2,
              color: isActive ? AppColors.primary : AppColors.gray,
            ),
          );
        } else {
          // Step circle
          final stepIndex = index ~/ 2;
          final isActive = stepIndex <= currentStep;
          final isCurrent = stepIndex == currentStep;

          return Column(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary : AppColors.gray,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: isActive && stepIndex < currentStep
                      ? const Icon(Icons.check, size: 16, color: AppColors.white)
                      : Text(
                    '${stepIndex + 1}',
                    style: TextStyle(
                      color: isActive ? AppColors.white : AppColors.darkGray,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                steps[stepIndex],
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: isCurrent
                      ? AppColors.primary
                      : isDark
                      ? AppColors.white
                      : AppColors.darkGray,
                ),
              ),
            ],
          );
        }
      }),
    );
  }

  Widget _buildSectionHeader(
      String title,
      String action,
      TextTheme textTheme,
      Color textColor,
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(color: textColor),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            action,
            style: textTheme.titleSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddressCard({
    required Map<String, dynamic> address,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDark,
    required TextTheme textTheme,
    required Color textColor,
    required Color subtitleColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.black : AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withOpacity(0.1)
                    : AppColors.gray,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                address['icon'] == 'home' ? Icons.home : Icons.work_outline,
                color: isSelected ? AppColors.primary : AppColors.darkGray,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            // Address Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address['title'],
                    style: textTheme.titleMedium?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address['address'],
                    style: textTheme.titleSmall?.copyWith(
                      color: subtitleColor,
                      height: 1.4,
                    ),
                  ),
                  if (address['phone'] != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      address['phone'],
                      style: textTheme.titleSmall?.copyWith(
                        color: subtitleColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // Edit Button
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'EDIT',
                style: textTheme.titleSmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentCard({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDark,
    required TextTheme textTheme,
    required Color textColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: isDark ? AppColors.black : AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.darkGray,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: textTheme.titleSmall?.copyWith(
                color: isSelected ? AppColors.primary : textColor,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary({
    required TextTheme textTheme,
    required Color textColor,
    required Color subtitleColor,
    required bool isDark,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.black : AppColors.gray.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        iconColor: textColor,
        collapsedIconColor: textColor,
        title: Row(
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 20,
              color: textColor,
            ),
            const SizedBox(width: 8),
            Text(
              'Order Summary (2 items)',
              style: textTheme.titleSmall?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        children: [
          // Order items would go here
          _buildOrderItem(
            name: 'Premium Leather Jacket',
            qty: 1,
            price: 350.00,
            textTheme: textTheme,
            textColor: textColor,
            subtitleColor: subtitleColor,
          ),
          const Divider(height: 24),
          _buildOrderItem(
            name: 'Denim Jeans',
            qty: 1,
            price: 220.00,
            textTheme: textTheme,
            textColor: textColor,
            subtitleColor: subtitleColor,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildOrderItem({
    required String name,
    required int qty,
    required double price,
    required TextTheme textTheme,
    required Color textColor,
    required Color subtitleColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: textTheme.titleSmall?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Qty: $qty',
                style: textTheme.titleSmall?.copyWith(
                  color: subtitleColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Text(
          '\$${price.toStringAsFixed(2)}',
          style: textTheme.titleSmall?.copyWith(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}