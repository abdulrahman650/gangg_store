import 'package:gangg_store/features/reviews/data/model/review_data_model.dart';

class ReviewsResponseModel {
  final String? message;
  final double? averageRating;
  final int? reviewsCount;
  final ReviewsDataModel? reviews;

  ReviewsResponseModel({
    this.message,
    this.averageRating,
    this.reviewsCount,
    this.reviews,
  });

  factory ReviewsResponseModel.fromJson(Map<String, dynamic> json) {
    return ReviewsResponseModel(
      message: json['message'],
      averageRating: json['averageRating']?.toDouble(),
      reviewsCount: json['reviewsCount'],
      reviews: json['reviews'] == null
          ? null
          : ReviewsDataModel.fromJson(json['reviews']),
    );
  }
}
