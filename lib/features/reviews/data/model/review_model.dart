class ReviewModel {
  final String? message;
  final int? id;
  final int? productId;
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
      id: json["id"],
      productId: json["productId"],
      comment: json["comment"],
      rating: json["rating"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "id": id,
      "productId": productId,
      "comment": comment,
      "rating": rating,
    };
  }
}
