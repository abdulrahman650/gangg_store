import 'offer_model.dart';

class OffersResponseModel {
  final List<OfferModel> items;
  final int page;
  final int pageSize;
  final int totalCount;
  final bool hasNextPage;
  final bool hasPreviousPage;

  OffersResponseModel({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  factory OffersResponseModel.fromJson(Map<String, dynamic> json) {
    final offers = json['offers'] as Map<String, dynamic>;
    return OffersResponseModel(
      items: (offers['items'] as List<dynamic>)
          .map((e) => OfferModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: offers['page'] as int,
      pageSize: offers['pageSize'] as int,
      totalCount: offers['totalCount'] as int,
      hasNextPage: offers['hasNextPage'] as bool,
      hasPreviousPage: offers['hasPreviousPage'] as bool,
    );
  }
}