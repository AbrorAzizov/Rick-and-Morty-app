import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../bloc/theme/theme_cubit.dart';
import '../widgets/character_list.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<CharacterBloc>().add(LoadCharacters());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        final bloc = context.read<CharacterBloc>();
        final state = bloc.state;
        if (state is CharacterLoaded && state.hasMore) {
          bloc.add(LoadMoreCharacters(state.currentPage));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    return Scaffold(
      appBar: AppBar(

      leading:  IconButton(
        icon: Icon(
          context.watch<ThemeCubit>().state == ThemeMode.light
              ? Icons.dark_mode
              : Icons.light_mode,
          color: context.watch<ThemeCubit>().state == ThemeMode.light
              ? Colors.indigoAccent
              : Colors.yellow,
        ),

        onPressed: () => themeCubit.toggleTheme(),
      ),
      ),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          if (state is CharacterLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CharacterError) {
            return Center(child: Text("Error: ${state.message}"));
          } else if (state is CharacterLoaded) {
            final characters = state.characters;

            return ListView.builder(
              controller: _scrollController,
              itemCount: characters.length + (state.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < characters.length) {
                  final character = characters[index];
                  return CharacterWidget(character: character);
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
