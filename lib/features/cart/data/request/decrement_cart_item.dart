class DecrementCartItem {
  final String cartItemId;
  final String quantity;

  DecrementCartItem({
    
 required this.cartItemId, required this.quantity});
 Map<String,dynamic>toJson(){
    return{
    "itemId":cartItemId,
    "quantity":quantity,

    };
}}