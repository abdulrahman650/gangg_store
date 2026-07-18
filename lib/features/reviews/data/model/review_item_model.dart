class ReviewItemModel {
  final String? comment;
  final int? rating;
  final String? createdAt;
  final String? userName;
  final String? userPicture;

  ReviewItemModel({
    this.comment,
    this.rating,
    this.createdAt,
    this.userName,
    this.userPicture,
  });

  factory ReviewItemModel.fromJson(Map<String, dynamic> json) {
    return ReviewItemModel(
      comment: json['comment'],
      rating: json['rating'],
      createdAt: json['createdAt'],
      userName: json['userName'],
      userPicture: json['userPicture'],
    );
  }
}
