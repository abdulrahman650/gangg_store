class OfferModel {
  final String id;
  final String name;
  final String description;
  final String coverUrl;
  final DateTime createdAt;

  static const String fallbackImageUrl =
      'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=800';
  static const String fallbackName = 'Special Offer';
  static const String fallbackDescription = 'Limited time offer';

  OfferModel({
    required this.id,
    required this.name,
    required this.description,
    required this.coverUrl,
    required this.createdAt,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'] as String? ?? '',
      name: (json['name'] as String?)?.isNotEmpty == true
          ? json['name'] as String
          : fallbackName,
      description: (json['description'] as String?)?.isNotEmpty == true
          ? json['description'] as String
          : fallbackDescription,
      coverUrl: json['coverUrl'] as String? ?? fallbackImageUrl,
      createdAt: _parseDate(json['createdAt']),
    );
  }

  static DateTime _parseDate(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (_) {
        return DateTime.now();
      }
    }
    return DateTime.now();
  }

  String get imageUrl => coverUrl.isNotEmpty ? coverUrl : fallbackImageUrl;
}