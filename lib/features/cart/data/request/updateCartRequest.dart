class UpdateCartRequest {
  final String id;
  final int quantity;

  UpdateCartRequest({
    required this.id,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "quantity": quantity,
    };
  }
}