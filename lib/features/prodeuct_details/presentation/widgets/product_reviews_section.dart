import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/features/home/data/model/product_model.dart';
import 'package:gangg_store/features/reviews/presentation/widget/product_reveiws_card.dart';
import 'package:gangg_store/features/reviews/presentation/widget/rating_sammary.dart';
import 'package:gangg_store/features/reviews/presentation/widget/review_card.dart';
import 'package:gangg_store/features/reviews/presentation/widget/write_reveiw_card.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../reviews/data/model/review_response_model.dart';
import '../../../reviews/data/request/add_review_request.dart';
import '../../../reviews/presentation/cubit/review_cubit.dart';
import '../../../reviews/presentation/cubit/review_state.dart';

class ProductReviewsSection extends StatelessWidget {
  final ProductModel product;
  final ReviewsResponseModel reviews;

  const ProductReviewsSection({
    super.key,
    required this.product,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    final items = reviews.reviews?.items ?? [];

    final fiveStars = items.where((e) => e.rating == 5).length;
    final fourStars = items.where((e) => e.rating == 4).length;
    final threeStars = items.where((e) => e.rating == 3).length;
    final twoStars = items.where((e) => e.rating == 2).length;
    final oneStar = items.where((e) => e.rating == 1).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductReviewCard(
          imageUrl: product.coverPictureUrl,
          productName: product.name,
          price: product.price,
          averageRating: reviews.averageRating ?? 0,
        ),

        const SizedBox(height: 24),

        RatingSummary(
          averageRating: reviews.averageRating ?? 0,
          totalReviews: reviews.reviewsCount ?? 0,
          fiveStars: fiveStars,
          fourStars: fourStars,
          threeStars: threeStars,
          twoStars: twoStars,
          oneStar: oneStar,
        ),

        const SizedBox(height: 24),

        BlocListener<ReviewCubit, ReviewState>(
          listener: (context, state) {
            if (state is AddReviewSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Review added successfully"),
                ),
              );

              context.read<ReviewCubit>().getReviews(
                productId: product.id,
              );
            }

            if (state is ReviewError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: WriteReviewCard(
            onSubmit: (rating, comment) {
              context.read<ReviewCubit>().addReview(
                AddReviewRequest(
                  productId: product.id,
                  rating: rating.toInt(),
                  comment: comment,
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 24),

         Text(
          "Customer Reviews",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: context.isDark
                ? AppColors.white
                : AppColors.black,
          ),
        ),

        const SizedBox(height: 16),

        if (items.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text("No reviews yet"),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final review = items[index];

              return ReviewCard(
                userName: review.userName ?? "Unknown User",
                comment: review.comment ?? "",
                rating: (review.rating ?? 0).toDouble(),
                date: review.createdAt ?? "",
                images: const [],
              );
            },
          ),
      ],
    );
  }
}