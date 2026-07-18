// import 'package:flutter/material.dart';
//
// class AuthViewModel extends ChangeNotifier {
//   bool _isLoading = false;
//   String? _errorMessage;
//
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//   Future<void> login() async {
//     if (!formKey.currentState!.validate()) return;
//
//     _setLoading(true);
//     _errorMessage = null;
//
//     try {
//       // TODO: Call your API here
//       await Future.delayed(const Duration(seconds: 2));
//     } catch (e) {
//       _errorMessage = e.toString();
//     } finally {
//       _setLoading(false);
//     }
//   }
//
//   Future<void> register() async {
//     if (!formKey.currentState!.validate()) return;
//
//     _setLoading(true);
//     _errorMessage = null;
//
//     try {
//       // TODO: Call your API here
//       await Future.delayed(const Duration(seconds: 2));
//     } catch (e) {
//       _errorMessage = e.toString();
//     } finally {
//       _setLoading(false);
//     }
//   }
//
//   void _setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }
//
//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     nameController.dispose();
//     phoneController.dispose();
//     confirmPasswordController.dispose();
//     super.dispose();
//   }
// }