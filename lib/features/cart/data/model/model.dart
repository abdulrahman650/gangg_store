import 'dart:ffi';



class CartModel{
  final String message;
  final String?id;
  final String? productId;
  final Int quantity;

  CartModel({
    
   required this.message, 
   this.id, 
   this.productId,
   required this.quantity});


factory CartModel.fromJson(Map<String,dynamic>json){
  return CartModel(
  message:json['message'] , 
  id:json['id'],
  productId:json['productId'],
  quantity: json['quantity']);
}}