import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/favourite_cubit.dart';
import '../bloc/favourite_state.dart';
import '../widgets/favorites_list.dart';

class FavoritesTab extends StatefulWidget {
  const FavoritesTab({super.key});

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  String sortBy = 'name';
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<FavoritesCubit>().loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: (value) {
              setState(() => sortBy = value);
              context.read<FavoritesCubit>().sortFavourites(value);
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'name', child: Text('Sort by Name')),
              PopupMenuItem(value: 'status', child: Text('Sort by Status')),
              PopupMenuItem(value: 'species', child: Text('Sort by Species')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search favorites...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() => searchQuery = value);
                context.read<FavoritesCubit>().searchFavorites(value);
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<FavoritesCubit, FavoritesState>(
              builder: (context, state) {
                if (state is FavoritesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FavoritesError) {
                  return Center(child: Text(state.message));
                } else if (state is FavoritesLoaded) {
                  final favorites = state.favorites;
                  if (favorites.isEmpty) {
                    return const Center(
                      child: Text('No favorites found'),
                    );
                  }
                  return FavoritesList(favorites: favorites);
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
