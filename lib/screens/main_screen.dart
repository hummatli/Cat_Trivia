import 'package:cat_trivia/bloc/cat_fact/cat_fact/cat_fact_bloc.dart';
import 'package:cat_trivia/bloc/cat_fact/cat_fact/cat_fact_event.dart';
import 'package:cat_trivia/bloc/cat_fact/cat_fact/cat_fact_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat Trivia'),
      ),
      body: BlocConsumer<CatFactBloc, CatFactState>(
        listener: (context, state) {
          if (state is CatFactLoadFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Failed to load cat fact')),
              );
          }
        },
        builder: (context, state) {
          if (state is CatFactLoadSuccess) {
            print("State image = ${state.catImageUrl}");
            final catImageUrl =
                '${state.catImageUrl}?time=${DateTime.now().millisecondsSinceEpoch}'; // Append cache-busting query parameter

            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Text(state.catFact.text),
                    Text(state.catFact.createdAt.toString()),
                    Container(
                      width: 200,
                      height: 200,
                      child: Image.network(catImageUrl),
                    ),
                    ElevatedButton(
                      onPressed: () => BlocProvider.of<CatFactBloc>(context)
                          .add(CatFactRequested()),
                      child: const Text('Another fact!'),
                    ),
                    ElevatedButton(
                      onPressed: () => goRouter.go('/fact-history'),
                      child: const Text('Fact History'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is CatFactLoadFailure) {
            return Center(
              child: ElevatedButton(
                onPressed: () => BlocProvider.of<CatFactBloc>(context)
                    .add(CatFactRequested()),
                child: const Text('Retry'),
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
