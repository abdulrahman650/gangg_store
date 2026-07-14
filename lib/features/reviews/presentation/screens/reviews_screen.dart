import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gangg_store/core/services/service_locators.dart';
import 'package:gangg_store/features/reviews/data/request/add_review_request.dart';
import 'package:gangg_store/features/reviews/presentation/cubit/review_cubit.dart';
import 'package:gangg_store/features/reviews/presentation/cubit/review_state.dart';
import 'package:gangg_store/features/reviews/presentation/widget/product_reveiws_card.dart';
import 'package:gangg_store/features/reviews/presentation/widget/rating_sammary.dart';
import 'package:gangg_store/features/reviews/presentation/widget/review_card.dart';
import 'package:gangg_store/features/reviews/presentation/widget/write_reveiw_card.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<ReviewCubit>()
            ..getReviews(productId: "1", page: 1, pageSize: 10),
      child: Scaffold(
        backgroundColor: const Color(0xffF8F6F3),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text("Reviews"),
        ),
        body: BlocBuilder<ReviewCubit, ReviewState>(
          builder: (context, state) {
            if (state is ReviewLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ReviewError) {
              return Center(child: Text(state.message));
            }

            if (state is ReviewSuccess) {
              final response = state.reviews;

              return SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductReviewCard(
                        imageUrl: "https://picsum.photos/200",
                        productName: "Leather Tote Bag",
                        price: 240,
                        averageRating: response.averageRating ?? 0,
                      ),

                      const SizedBox(height: 24),

                      RatingSummary(
                        averageRating: response.averageRating ?? 0,
                        totalReviews: response.reviewsCount ?? 0,
                        fiveStars: 0,
                        fourStars: 0,
                        threeStars: 0,
                        twoStars: 0,
                        oneStar: 0,
                      ),

                      const SizedBox(height: 24),

                      WriteReviewCard(
                        onSubmit: (rating, comment) {
                          context.read<ReviewCubit>().addReview(
                            AddReviewRequest(
                              productId: "1", // غيريه بالـ ProductId الحقيقي
                              rating: rating.toInt(),
                              comment: comment,
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 32),

                      const Text(
                        "Customer Reviews",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: response.reviews?.items.length ?? 0,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final review = response.reviews!.items[index];

                          return ReviewCard(
                            userName: review.userName ?? "Unknown User",
                            comment: review.comment ?? "",
                            rating: (review.rating ?? 0).toDouble(),
                            date: review.createdAt ?? "",
                            images: const [],
                          );
                        },
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
