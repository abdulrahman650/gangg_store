class CartItemModel {
  final String itemId;
  final String productId;
  final String productName; 
  final String productCoverUrl;
  final int productStock;
  final int weightInGrams;
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
 required this.totalPrice});
 
 factory CartItemModel.fromJson(Map<String,dynamic>json){
  return CartItemModel(
   itemId: json["itemId"],
   productId: json["productId"],
   productName: json["productName"],
   productCoverUrl: json["productCoverUrl"],
   productStock: json["productStock"],
   weightInGrams: json["weightInGrams"],
   quantity: json["quantity"],
   discountPercentage: json["discountPercentage"],
   basePricePerUnit: json["basePricePerUnit"],
   finalPricePerUnit: json["finalPricePerUnit"],
   totalPrice: json["totalPrice"]);
 }
}
