import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/favourite_cubit.dart';
import '../bloc/favourite_state.dart';
import '../widgets/favorite_list.dart';

class FavoritesTab extends StatefulWidget {
  const FavoritesTab({super.key});

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  String sortBy = 'name';
  final TextEditingController controller = TextEditingController();

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
          final favorites = state.favorites;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    PopupMenuButton<String>(
                      initialValue: sortBy,
                      onSelected: (value) {
                        setState(() => sortBy = value);
                        context.read<FavoritesCubit>().sortFavourites(value);
                      },
                      itemBuilder: (_) => const [
                        PopupMenuItem(value: 'name', child: Text('Sort by Name')),
                        PopupMenuItem(value: 'status', child: Text('Status')),
                        PopupMenuItem(value: 'species', child: Text('Species')),
                      ],
                      icon: const Icon(Icons.sort_sharp),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: 'Search favorites...',
                          border: const OutlineInputBorder(),
                          contentPadding:
                          const EdgeInsets.symmetric(horizontal: 8),
                          suffixIcon: controller.text.isNotEmpty
                              ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              controller.clear();
                              context
                                  .read<FavoritesCubit>()
                                  .searchFavorites('');
                            },
                          )
                              : null,
                        ),
                        onChanged: (value) {
                          context
                              .read<FavoritesCubit>()
                              .searchFavorites(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: favorites.isEmpty
                    ? const Center(child: Text('No favorites found'))
                    : ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: favorites.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final character = favorites[index];
                    return FavoriteList(character: character);
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
}
