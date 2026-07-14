import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/features/reviews/data/repos/review_repository.dart';

import '../../data/model/review_model.dart';

import '../../data/request/add_review_request.dart';
import 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final ReviewRepository repository;

  ReviewCubit(this.repository) : super(ReviewInitial());
  Future<void> getReviews({
    required String productId,
    int page = 1,
    int pageSize = 10,
  }) async {
    emit(ReviewLoading());

    try {
      final result = await repository.getReviews(
        productId: productId,
        page: page,
        pageSize: pageSize,
      );

      emit(ReviewSuccess(result));
    } catch (e) {
      emit(ReviewError(e.toString()));
    }
  }

  Future<void> addReview(AddReviewRequest request) async {
    emit(ReviewLoading());

    try {
      final result = await repository.addReview(request);

      emit(AddReviewSuccess(result));
    } catch (e) {
      emit(ReviewError(e.toString()));
    }
  }
}
