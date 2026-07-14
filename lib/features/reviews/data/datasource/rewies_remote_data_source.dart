import 'package:gangg_store/features/reviews/data/model/review_model.dart';
import 'package:gangg_store/features/reviews/data/model/review_response_model.dart';

import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/api_endpoints.dart';

import '../request/add_review_request.dart';

abstract class ReviewRemoteDataSource {
  Future<ReviewModel> addReview(AddReviewRequest request);

  Future<ReviewsResponseModel> getReviews({
    required String productId,
    required int page,
    required int pageSize,
  });
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final ApiConsumer api;

  ReviewRemoteDataSourceImpl(this.api);

  @override
  Future<ReviewModel> addReview(AddReviewRequest request) async {
    final response = await api.post(
      '${EndPoints.postReview}/${request.productId}',
      data: request.toJson(),
    );

    return ReviewModel.fromJson(response);
  }

  @override
  Future<ReviewsResponseModel> getReviews({
    required String productId,
    required int page,
    required int pageSize,
  }) async {
    final response = await api.get(
      '${EndPoints.getReview}/$productId',
      queryParameters: {"page": page, "pageSize": pageSize},
    );

    return ReviewsResponseModel.fromJson(response);
  }
}
