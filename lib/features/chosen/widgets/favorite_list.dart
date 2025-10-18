import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/colors/app_colors.dart';
import '../../chosen/bloc/favourite_cubit.dart';
import '../../chosen/bloc/favourite_state.dart';
import '../../home/domain/entity/character.dart';


class FavoriteList extends StatelessWidget {
  final VoidCallback? onDelete;
  const FavoriteList({super.key, required this.character, this.onDelete});
  final Character character;


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final favoritesCubit = context.read<FavoritesCubit>();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDark ? AppColors.darkShadow : AppColors.lightShadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => debugPrint('Tapped '),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              // 🖼 Character image
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: character.image,
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: AppColors.placeholder,
                    height: 90,
                    width: 90,
                    alignment: Alignment.center,
                    child: const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error, color: AppColors.dead),
                ),
              ),

              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      character.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      character.species,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Status: ${character.status}",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: _statusColor(character.status),
                      ),
                    ),
                  ],
                ),
              ),

              // 🗑 Delete from favorites
              BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, state) {
                  return IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: AppColors.favoriteInactive,
                      size: 30,
                    ),
                    onPressed: () {
                      onDelete?.call();
                      favoritesCubit.deleteFavorite(character);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'alive':
        return AppColors.alive;
      case 'dead':
        return AppColors.dead;
      default:
        return AppColors.unknown;
    }
  }

}

