import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../core/utils/default_elevated_button.dart';
import '../../data/model/get_cart_model.dart';
import '../cubit/cart_cubit.dart';


class CheckoutScreen extends StatefulWidget {
  final GetCartModel cart;

  const CheckoutScreen({
    super.key,
    required this.cart,
  });


  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  int selectedPaymentIndex = 0;

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void placeOrder() {
    if (nameController.text.trim().isEmpty ||
        addressController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please complete all fields"),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 35,
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Order Placed Successfully",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Your order is now being prepared.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      context.read<CartCubit>().clearCart();

                      Navigator.pop(context); // dialog

                      Navigator.pop(context); // checkout
                    },
                  child: const Text("Done",style: TextStyle(color: AppColors.white),),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final subtotal = widget.cart.cartItems.fold<double>(
      0,
          (sum, item) => sum + item.totalPrice,
    );

    const shipping = 50.0;

    final total = subtotal + shipping;

    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.backgroundDark : AppColors.backgroundWhite;
    final textColor = isDark ? AppColors.white : AppColors.black;
    final subtitleColor = AppColors.darkGray;

    return Scaffold(
      backgroundColor: context.isDark
          ? Theme.of(context).scaffoldBackgroundColor
          : AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: context.isDark
            ? Theme.of(context).scaffoldBackgroundColor
            : AppColors.backgroundWhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Gang Store',
          style: textTheme.titleLarge?.copyWith(
              color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_bag_outlined, color: AppColors.primary),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Full Name",
                hintText: "Enter your full name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: "Address",
                hintText: "Enter your address",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Phone Number",
                hintText: "Enter your phone number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Payment Method Section
            Text(
              'Payment Method',
              style: textTheme.titleMedium?.copyWith(color:context.isDark
              ? AppColors.white
                  : AppColors.darkGray,),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _buildPaymentCard(
                    title: 'Cash On Delivery',
                    icon: Icons.money,
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
                    title: 'Visa',
                    icon: Icons.credit_card,
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
                        color: context.isDark
                            ? AppColors.white
                            : AppColors.darkGray,
                        fontSize: 12,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 4),

                    Text(
                      "\$${total.toStringAsFixed(2)}",
                      style: textTheme.titleMedium?.copyWith(
                        color: AppColors.primary,
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
              onPressed: placeOrder,
              prefixSvgPath: 'assets/icons/arrow_right',
            ),
            const SizedBox(height: 24),
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
              'Order Summary (${widget.cart.cartItems.length} items)',
              style: textTheme.titleSmall?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        children: [
          ...widget.cart.cartItems.map(
                (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildOrderItem(
                name: item.productName,
                qty: item.quantity,
                price: item.totalPrice,
                textTheme: textTheme,
                textColor: textColor,
                subtitleColor: subtitleColor,
              ),
            ),
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