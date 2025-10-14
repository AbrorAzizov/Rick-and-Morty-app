import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../chosen/bloc/favourite_cubit.dart';
import '../../chosen/bloc/favourite_state.dart';
import '../domain/entity/character.dart';

import 'icon_and_label.dart';

class CharacterWidget extends StatelessWidget {
  const CharacterWidget({super.key, required this.character});
  final Character character;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final favoritesCubit = context.read<FavoritesCubit>();
   favoritesCubit.isFavorite(character.id);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => debugPrint('Character tapped: ${character.name}'),
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? Colors.greenAccent.shade100 : Colors.indigoAccent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: CachedNetworkImage(
                imageUrl: character.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 180,
                placeholder: (context, url) => Container(
                  color: Colors.grey,
                  alignment: Alignment.center,
                  child: const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.error, color: Colors.red)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            character.name,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.circle,
                            size: 16,
                            color: _statusColor(character.status),
                          ),
                        ],
                      ),
                      BlocBuilder<FavoritesCubit, FavoritesState>(
                        builder: (context, state) {
                          final isFavorite = favoritesCubit.isFavorite(character.id);
                          return IconButton(
                            onPressed: () {
                              favoritesCubit.toggleFavorite(character);
                            },
                            icon: Icon(
                              isFavorite ? Icons.star : Icons.star_border,
                              size: 30,
                              color: isFavorite ? Colors.amber : Colors.grey,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  if (character.species.isNotEmpty)
                    IconAndLabel(
                      label: character.species,
                      icon: Icons.face,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return Colors.green;
      case 'dead':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
