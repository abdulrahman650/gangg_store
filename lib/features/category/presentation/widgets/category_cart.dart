import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
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
    final text = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(.75),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.12),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: imageAsset != null &&
                    imageAsset!.isNotEmpty &&
                    imageAsset!.startsWith("http")
                    ? Image.network(
                  imageAsset!,
                  fit: BoxFit.cover,
                  loadingBuilder: (_, child, progress) {
                    if (progress == null) return child;

                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        color: Colors.white,
                      ),
                    );
                  },
                  errorBuilder: (_, __, ___) {
                    return _buildPlaceholder();
                  },
                )
                    : _buildPlaceholder(),
              ),
            ),

            if (svgAsset != null &&
                svgAsset!.isNotEmpty &&
                (imageAsset == null || imageAsset!.isEmpty))
              Positioned(
                top: isWide ? 12 : 18,
                right: isWide ? 30 : 12,
                child: Opacity(
                  opacity: .25,
                  child: SvgPicture.asset(
                    svgAsset!,
                    width: isWide ? 130 : 85,
                    height: isWide ? 130 : 85,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),

            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black54,
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
                    title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: text.titleMedium?.copyWith(
                      color: Colors.white,
                      fontSize: isWide ? 18 : 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: text.bodySmall?.copyWith(
                      color: Colors.white70,
                      fontSize: isWide ? 12 : 10,
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

  Widget _buildPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey.shade200,
            Colors.grey.shade400,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.category_outlined,
          color: Colors.white70,
          size: 45,
        ),
      ),
    );
  }
}