class ReviewModel {
  final String? message;
  final String? id;
  final String? productId;
  final String? comment;
  final int? rating;

  ReviewModel({
    this.message,
    this.id,
    this.productId,
    this.comment,
    this.rating,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      message: json["message"],
      id: json["id"]?.toString(),
      productId: json["productId"]?.toString(),
      comment: json["comment"],
      rating: json["rating"],
    );
  }
}