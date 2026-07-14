class AddReviewRequest {
  final int rating;
  final String productId;
  final String? comment;

  AddReviewRequest({
    required this.rating,
    required this.productId,
    this.comment,
  });

  Map<String, dynamic> toJson() {
    return {"productId": productId, "comment": comment, "rating": rating};
  }
}
