import 'package:cat_trivia/data/cache_repository.dart';
import 'package:cat_trivia/data/cat_trivia_repository.dart';
import 'package:cat_trivia/di/injection_container.dart';
import 'package:cat_trivia/features/cat_fact/bloc/cat_fact_bloc.dart';
import 'package:cat_trivia/features/cat_fact/bloc/cat_fact_event.dart';
import 'package:cat_trivia/features/cat_fact/bloc/cat_fact_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cat_trivia/extensions/datetime_extensions.dart';

class CatFactPage extends StatelessWidget {
  final CatFactBloc catFactBloc;

  CatFactPage({Key? key})
      : catFactBloc = CatFactBloc(
            catTriviaRepository: getIt<CatTriviaRepository>(),
            cacheRepository: getIt<CacheRepository>()),
        super(key: key) {
    _loadInitialCatFact();
    print("CatFactPage constructor called");

  }

  void _loadInitialCatFact() {
    catFactBloc.add(CatFactRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: catFactBloc,
      child: Scaffold(
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
            return Column(
              children: [
                Expanded(
                  child: Builder(builder: (context) {
                    if (state is CatFactLoadSuccess) {
                      return Scrollbar(
                        child: SingleChildScrollView(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 8.0),
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          width: constraints.maxWidth,
                                          // Match the screen width
                                          height: 300,
                                          child: FadeInImage.assetNetwork(
                                            placeholder:
                                                'assets/images/placeholder.jpg',
                                            // Path to your placeholder image
                                            image: state.catImageUrl,
                                            // The network image URL
                                            fit: BoxFit.fitHeight,
                                          )),
                                      const SizedBox(
                                        height: 24.0,
                                      ),
                                      Text(
                                        state.catFact.createdAt.formatDate(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      Text(
                                        state.catFact.text,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (state is CatFactLoadFailure) {
                      return Center(
                        child: ElevatedButton(
                          onPressed: () => BlocProvider.of<CatFactBloc>(context)
                              .add(CatFactRequested()),
                          child: const Text('Retry'),
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 32.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => BlocProvider.of<CatFactBloc>(context)
                            .add(CatFactRequested()),
                        child: const Text('Another fact!'),
                      ),
                      const SizedBox(width: 32.0),
                      ElevatedButton(
                        onPressed: () =>
                            GoRouter.of(context).push('/fact-history'),
                        child: const Text('Fact History'),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
