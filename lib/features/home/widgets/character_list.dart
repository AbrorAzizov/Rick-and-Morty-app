import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../domain/entity/character.dart';

class CharacterWidget extends StatelessWidget {
  const CharacterWidget({super.key, required this.character});
  final Character character;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
              color: Colors.black.withOpacity(0.05),
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
                  color: Colors.grey.withOpacity(0.3),
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
                    children: [
                      Expanded(
                        child: Text(
                          character.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Tooltip(
                        message: character.status,
                        child: Icon(
                          Icons.circle,
                          size: 12,
                          color: _statusColor(character.status),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  if (character.species.isNotEmpty)
                    _IconAndLabel(
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

class _IconAndLabel extends StatelessWidget {
  const _IconAndLabel({required this.label, required this.icon});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 16, color: theme.iconTheme.color),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
