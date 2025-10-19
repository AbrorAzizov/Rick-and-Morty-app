import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_mort_test/features/home/domain/entity/character.dart';

import '../bloc/favourite_cubit.dart';
import 'favorite_item.dart';

class FavoritesList extends StatefulWidget {
  final List<Character> favorites;

  const FavoritesList({super.key, required this.favorites});

  @override
  State<FavoritesList> createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  late List<Character> _items;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.favorites);
  }

  @override
  void didUpdateWidget(FavoritesList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.favorites.length < _items.length) {
      // find removed items
      for (final oldItem in _items) {
        if (!widget.favorites.contains(oldItem)) {
          final index = _items.indexOf(oldItem);
          _removeItem(index);
          break;
        }
      }
    } else {
      _items = List.from(widget.favorites);
    }
  }

  void _removeItem(int index) {
    final removedItem = _items.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
          (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: FavoriteItem(
          character: removedItem,
          onDelete: () {},
        ),
      ),
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      initialItemCount: _items.length,
      itemBuilder: (context, index, animation) {
        final character = _items[index];
        return SizeTransition(
          key: ValueKey(character.id),
          sizeFactor: animation,
          child: FavoriteItem(
            character: character,
            onDelete: () {
              _removeItem(index);
              context.read<FavoritesCubit>().deleteFavorite(character);
            },
          ),
        );
      },
    );
  }
}
