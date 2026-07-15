import 'package:gangg_store/features/reviews/data/model/review_item_model.dart';

class ReviewsDataModel {
  final List<ReviewItemModel> items;

  ReviewsDataModel({required this.items});

  factory ReviewsDataModel.fromJson(Map<String, dynamic> json) {
    return ReviewsDataModel(
      items: (json['items'] as List)
          .map((e) => ReviewItemModel.fromJson(e))
          .toList(),
    );
  }
}
