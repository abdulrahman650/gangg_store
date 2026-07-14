import 'package:gangg_store/features/reviews/data/datasource/rewies_remote_data_source.dart';
import 'package:gangg_store/features/reviews/data/model/review_model.dart';
import 'package:gangg_store/features/reviews/data/model/review_response_model.dart';
import 'package:gangg_store/features/reviews/data/request/add_review_request.dart';

abstract class ReviewRepository {
  Future<ReviewModel> addReview(AddReviewRequest request);

  Future<ReviewsResponseModel> getReviews({
    required String productId,
    required int page,
    required int pageSize,
  });
}

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource remoteDataSource;

  ReviewRepositoryImpl(this.remoteDataSource);

  @override
  Future<ReviewModel> addReview(AddReviewRequest request) {
    return remoteDataSource.addReview(request);
  }

  @override
  Future<ReviewsResponseModel> getReviews({
    required String productId,
    required int page,
    required int pageSize,
  }) {
    return remoteDataSource.getReviews(
      productId: productId,
      page: page,
      pageSize: pageSize,
    );
  }
}
