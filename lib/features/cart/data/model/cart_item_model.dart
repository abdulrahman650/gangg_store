class CartItemModel {
  final String itemId;
  final String productId;
  final String productName;
  final String productCoverUrl;
  final int productStock;
  final double weightInGrams;
  final int quantity;
  final double discountPercentage;
  final double basePricePerUnit;
  final double finalPricePerUnit;
  final double totalPrice;

  CartItemModel({
    required this.itemId,
    required this.productId,
    required this.productName,
    required this.productCoverUrl,
    required this.productStock,
    required this.weightInGrams,
    required this.quantity,
    required this.discountPercentage,
    required this.basePricePerUnit,
    required this.finalPricePerUnit,
    required this.totalPrice,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      itemId: json["itemId"] as String,
      productId: json["productId"] as String,
      productName: json["productName"] as String,
      productCoverUrl: json["productCoverUrl"] as String,
      productStock: (json["productStock"] as num).toInt(),
      weightInGrams: (json["weightInGrams"] as num).toDouble(),
      quantity: (json["quantity"] as num).toInt(),
      discountPercentage:
      (json["discountPercentage"] as num).toDouble(),
      basePricePerUnit:
      (json["basePricePerUnit"] as num).toDouble(),
      finalPricePerUnit:
      (json["finalPricePerUnit"] as num).toDouble(),
      totalPrice:
      (json["totalPrice"] as num).toDouble(),
    );
  }

  CartItemModel copyWith({
    String? itemId,
    String? productId,
    String? productName,
    String? productCoverUrl,
    int? productStock,
    double? weightInGrams,
    int? quantity,
    double? discountPercentage,
    double? basePricePerUnit,
    double? finalPricePerUnit,
    double? totalPrice,
  }) {
    return CartItemModel(
      itemId: itemId ?? this.itemId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productCoverUrl: productCoverUrl ?? this.productCoverUrl,
      productStock: productStock ?? this.productStock,
      weightInGrams: weightInGrams ?? this.weightInGrams,
      quantity: quantity ?? this.quantity,
      discountPercentage:
      discountPercentage ?? this.discountPercentage,
      basePricePerUnit:
      basePricePerUnit ?? this.basePricePerUnit,
      finalPricePerUnit:
      finalPricePerUnit ?? this.finalPricePerUnit,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}