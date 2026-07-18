class EndPoints {
  static const String baseUrl = 'https://accessories-eshop.runasp.net/api/';

  // ===================== Auth =====================

  static const String login = 'auth/login';
  static const String register = 'auth/register';
  static const String logout = 'auth/logout';
  static const String me = 'auth/me';
  static const String refreshToken = 'auth/refresh-token';
  static const String verifyEmail = 'auth/verify-email';
  static const String resendOtp = 'auth/resend-otp';
  static const String validateOtp = 'auth/validate-otp';
  static const String forgotPassword = 'auth/forgot-password';
  static const String resetPassword = 'auth/reset-password';
  static const String changePassword = 'auth/change-password';

  // ===================== Products =====================

  static const String products = 'products';
  static String productById(String id) => 'products/$id';

  // ===================== Categories =====================

  static const String categories = 'categories';
  static String categoryById(String id) => 'categories/$id';

  // ===================== Offers =====================

  static const String offers = 'offers';

  // ===================== Reviews =====================

  static String getReview(String productId) => 'reviews/$productId';
  static String postReview(String productId) => 'reviews/$productId';

  // ===================== Cart =====================

  static const String getCart = 'cart';
  static const String addToCart = 'cart/items';
  static const String decrementCartItem = 'cart/items/decrement';
  static const String applyCoupon = 'cart/apply-coupon';

  static String deleteCartItem(String id) => 'cart/items/$id';

  static String updateCartItem(String id) => 'cart/items/$id';
}