import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gangg_store/core/theme/app_colors.dart';

class CategoryItem extends StatelessWidget {
  final String label;
  final String? imageUrl;
  final VoidCallback? onTap;

  const CategoryItem({
    super.key,
    required this.label,
    this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: SizedBox(
          width: 72,
          child: Column(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.gray,
                child: ClipOval(
                  child: imageUrl != null && imageUrl!.isNotEmpty
                      ? CachedNetworkImage(
                    imageUrl: imageUrl!,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => const Icon(
                      Icons.category,
                      color: AppColors.darkGray,
                      size: 26,
                    ),
                  )
                      : const Icon(
                    Icons.category,
                    color: AppColors.darkGray,
                    size: 26,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkGray,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}