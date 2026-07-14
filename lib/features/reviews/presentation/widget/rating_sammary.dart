import 'package:flutter/material.dart';

class RatingSummary extends StatelessWidget {
  final double averageRating;
  final int totalReviews;

  final int fiveStars;
  final int fourStars;
  final int threeStars;
  final int twoStars;
  final int oneStar;

  const RatingSummary({
    super.key,
    required this.averageRating,
    required this.totalReviews,
    required this.fiveStars,
    required this.fourStars,
    required this.threeStars,
    required this.twoStars,
    required this.oneStar,
  });

  @override
  Widget build(BuildContext context) {
    final total = totalReviews == 0 ? 1 : totalReviews;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Rating Summary",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Text(
                averageRating.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(width: 20),

              Expanded(
                child: Column(
                  children: [
                    _ratingBar(5, fiveStars / total),
                    _ratingBar(4, fourStars / total),
                    _ratingBar(3, threeStars / total),
                    _ratingBar(2, twoStars / total),
                    _ratingBar(1, oneStar / total),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Text(
            "$totalReviews Reviews",
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _ratingBar(int star, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 18, child: Text("$star")),

          const Icon(Icons.star, color: Colors.amber, size: 16),

          const SizedBox(width: 8),

          Expanded(
            child: LinearProgressIndicator(
              value: value,
              minHeight: 8,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }
}
