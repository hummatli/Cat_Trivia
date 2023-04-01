import 'package:flutter/material.dart';
import '../models/cat_fact.dart';
import '../repository/cat_trivia_repository.dart';

class FactHistoryScreen extends StatelessWidget {
  final CatTriviaRepository catTriviaRepository;

  const FactHistoryScreen({Key? key, required this.catTriviaRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fact History'),
      ),
      body: FutureBuilder<List<CatFact>>(
        future: catTriviaRepository.getSavedCatFacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final catFacts = snapshot.data!;
            return ListView.builder(
              itemCount: catFacts.length,
              itemBuilder: (context, index) {
                final catFact = catFacts[index];
                return ListTile(
                  title: Text(catFact.text),
                  subtitle: Text('Created at: ${catFact.createdAt}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
