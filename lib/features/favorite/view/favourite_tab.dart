import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/domain/entity/character.dart';
import '../../home/widgets/character_list.dart';
import '../bloc/favourite_cubit.dart';
import '../bloc/favourite_state.dart';

class FavoritesTab extends StatefulWidget {
  const FavoritesTab({super.key});

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  String sortBy = 'name';

  @override
  void initState() {
    super.initState();
    context.read<FavoritesCubit>().loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FavoritesError) {
          return Center(child: Text(state.message));
        } else if (state is FavoritesLoaded) {
          final favorites = _sortFavorites(state.favorites);
          if (favorites.isEmpty) {
            return const Center(child: Text('No favorites yet'));
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PopupMenuButton<String>(
                      initialValue: sortBy,
                      onSelected: (value) {
                        setState(() => sortBy = value);
                      },
                      itemBuilder: (_) => const [
                        PopupMenuItem(
                            value: 'name', child: Text('Sort by Name')),
                        PopupMenuItem(
                            value: 'status', child: Text('Sort by Status')),
                        PopupMenuItem(
                            value: 'species', child: Text('Sort by Species')),
                      ],
                      icon: const Icon(Icons.sort),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: favorites.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    final character = favorites[index];
                    return CharacterWidget(character: character);


                  },
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  List<Character> _sortFavorites(List<Character> list) {
    final sorted = List<Character>.from(list);
    switch (sortBy) {
      case 'name':
        sorted.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'status':
        sorted.sort((a, b) => a.status.compareTo(b.status));
        break;
      case 'species':
        sorted.sort((a, b) => a.species.compareTo(b.species));
        break;
    }
    return sorted;
  }
}
