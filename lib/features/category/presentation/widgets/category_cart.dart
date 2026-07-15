import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';
class CategoryCart extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? svgAsset;
  final String? imageAsset;
  final double height;
  final bool isWide;
  final VoidCallback? onTap;

  const CategoryCart({
    super.key,
    this.title,
    this.subtitle,
    this.svgAsset,
    this.imageAsset,
    required this.height,
    this.isWide = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme text = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.75),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.12),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            if (imageAsset != null)
              Positioned.fill(
                child: Image.network(
                  imageAsset!,
                  fit: BoxFit.cover,
                  loadingBuilder: (
                      BuildContext context,
                      Widget child,
                      ImageChunkEvent? loadingProgress,
                      ) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        color: Colors.white,
                      ),
                    );
                  },
                  errorBuilder: (_, __, ___) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              ),

            if (svgAsset != null && imageAsset == null)
              Positioned(
                top: isWide ? 12 : 18,
                right: isWide ? 30 : 12,
                child: Opacity(
                  opacity: 0.25,
                  child: SvgPicture.asset(
                    svgAsset!,
                    width: isWide ? 130 : 85,
                    height: isWide ? 130 : 85,
                    colorFilter: const ColorFilter.mode(
                      AppColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),

            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.black.withOpacity(0.05),
                      AppColors.black.withOpacity(0.70),
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: text.titleMedium?.copyWith(
                      color: AppColors.white,
                      fontSize: isWide ? 18 : 15,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: text.titleSmall?.copyWith(
                      color: AppColors.white.withOpacity(0.9),
                      fontSize: isWide ? 11 : 9,
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