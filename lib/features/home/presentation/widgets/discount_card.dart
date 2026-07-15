// import 'package:flutter/material.dart';
// import 'package:gangg_store/core/theme/app_colors.dart';
// import 'package:gangg_store/features/home/data/model/offer_model.dart';
//
// class DiscountCard extends StatelessWidget {
//   final List<OfferModel> offers;
//
//   const DiscountCard({super.key, required this.offers});
//
//   @override
//   Widget build(BuildContext context) {
//     if (offers.isEmpty) return const SizedBox.shrink();
//
//     return SizedBox(
//       height: 160,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: offers.length,
//         itemBuilder: (context, index) {
//           final offer = offers[index];
//           return Container(
//             width: 300,
//             margin: const EdgeInsets.only(right: 12),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16),
//               color: AppColors.gray,
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(16),
//               child: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   Image.network(
//                     offer.coverUrl,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         color: AppColors.gray,
//                         child: const Icon(
//                           Icons.image_not_supported,
//                           color: AppColors.darkGray,
//                           size: 48,
//                         ),
//                       );
//                     },
//                     loadingBuilder: (context, child, loadingProgress) {
//                       if (loadingProgress == null) return child;
//                       return Container(
//                         color: AppColors.gray,
//                         child: const Center(
//                           child: CircularProgressIndicator(
//                             color: AppColors.primary,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16),
//                       gradient: LinearGradient(
//                         begin: Alignment.bottomLeft,
//                         end: Alignment.topRight,
//                         colors: [
//                           Colors.black.withOpacity(0.7),
//                           Colors.transparent,
//                         ],
//                       ),
//                     ),
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Text(
//                           offer.name,
//                           style: const TextStyle(
//                             color: AppColors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           offer.description,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             color: AppColors.white.withOpacity(0.8),
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/features/home/data/model/offer_model.dart';

class DiscountCard extends StatelessWidget {
  final List<OfferModel> offers;

  const DiscountCard({super.key, required this.offers});

  @override
  Widget build(BuildContext context) {
    if (offers.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: offers.length,
        itemBuilder: (context, index) {
          final offer = offers[index];
          return _OfferCard(offer: offer);
        },
      ),
    );
  }
}

class _OfferCard extends StatefulWidget {
  final OfferModel offer;

  const _OfferCard({required this.offer});

  @override
  State<_OfferCard> createState() => _OfferCardState();
}

class _OfferCardState extends State<_OfferCard> {
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    final imageUrl = _hasError ? OfferModel.fallbackImageUrl : widget.offer.imageUrl;

    return Container(
      width: 320,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                if (!_hasError) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) setState(() => _hasError = true);
                  });
                }
                return Container(color: const Color(0xFF8B6914));
              },
            ),
            // Dark overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.2),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
            // Content FROM API
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Offer name FROM API
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB8956A),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.offer.name, // <-- FROM API
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Description FROM API
                  Text(
                    widget.offer.description, // <-- FROM API
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 11,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Shop Now button
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Shop Now',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward,
                            color: AppColors.primary,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}