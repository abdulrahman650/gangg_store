import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class NetworkImageWithShimmer extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const NetworkImageWithShimmer({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final image = Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded || frame != null) {
          return child;
        }

        return _buildShimmer(context);
      },
      errorBuilder: (_, __, ___) {
        return Container(
          width: width,
          height: height,
          color: AppColors.lightGray,
          child: const Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              color: Colors.grey,
              size: 45,
            ),
          ),
        );
      },
    );

    if (borderRadius == null) {
      return image;
    }

    return ClipRRect(
      borderRadius: borderRadius!,
      child: image,
    );
  }


  Widget _buildShimmer(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark
          ? Colors.grey.shade800
          : Colors.grey.shade300,

      highlightColor: isDark
          ? Colors.grey.shade700
          : Colors.grey.shade100,

      child: Container(
        width: width,
        height: height,
        color: Theme.of(context).cardColor,
      ),
    );
  }
}