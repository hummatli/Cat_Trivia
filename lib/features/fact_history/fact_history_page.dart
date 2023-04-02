import 'package:cat_trivia/features/fact_history/bloc/fact_history_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/fact_history_cubit.dart';

class FactHistoryPage extends StatelessWidget {
  const FactHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fact History'),
      ),
      body: BlocBuilder<FactHistoryCubit, FactHistoryState>(
        builder: (context, state) {
          if (state is FactHistoryLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FactHistoryLoadSuccess) {
            return ListView.builder(
              itemCount: state.factHistory.length,
              itemBuilder: (context, index) {
                final fact = state.factHistory[index];
                return ListTile(
                  title: Text(fact.text),
                  subtitle: Text(fact.createdAt.toString()),
                );
              },
            );
          } else {
            return const Center(child: Text('Failed to load fact history'));
          }
        },
      ),
    );
  }
}
