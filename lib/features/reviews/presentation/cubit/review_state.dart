import 'package:gangg_store/features/reviews/data/model/review_model.dart';
import 'package:gangg_store/features/reviews/data/model/review_response_model.dart';

abstract class ReviewState {}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewSuccess extends ReviewState {
  final ReviewsResponseModel reviews;

  ReviewSuccess(this.reviews);
}

class AddReviewSuccess extends ReviewState {
  final ReviewModel review;

  AddReviewSuccess(this.review);
}

class ReviewError extends ReviewState {
  final String message;

  ReviewError(this.message);
}
