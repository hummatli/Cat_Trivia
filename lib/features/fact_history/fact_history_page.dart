import 'package:cat_trivia/data/cache_repository.dart';
import 'package:cat_trivia/di/injection_container.dart';
import 'package:cat_trivia/extensions/datetime_extensions.dart';
import 'package:cat_trivia/features/fact_history/bloc/fact_history_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/fact_history_cubit.dart';

class FactHistoryPage extends StatelessWidget {
  final FactHistoryCubit factHistoryCubit;

  FactHistoryPage({Key? key})
      : factHistoryCubit = FactHistoryCubit(getIt<CacheRepository>()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => factHistoryCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Fact History'),
        ),
        body: BlocBuilder<FactHistoryCubit, FactHistoryState>(
          builder: (context, state) {
            if (state is FactHistoryLoadInProgress) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FactHistoryLoadSuccess) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: state.factHistory.length,
                  itemBuilder: (context, index) {
                    final fact = state.factHistory[index];
                    return ListTile(
                      title: Text(
                        fact.createdAt.formatDate(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        fact.text,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Center(child: Text('Failed to load fact history'));
            }
          },
        ),
      ),
    );
  }
}
