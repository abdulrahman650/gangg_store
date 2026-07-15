class CartModel {
  final String message;
  final String? id;
  final String? productId;
  final int quantity;

  CartModel({
    required this.message,
    this.id,
    this.productId,
    required this.quantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      message: json['message'] as String,
      id: json['id'] as String?,
      productId: json['productId'] as String?,
      quantity: (json['quantity'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'id': id,
      'productId': productId,
      'quantity': quantity,
    };
  }
}