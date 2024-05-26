import 'package:flutter/material.dart';
import 'package:what_do_i_like/ui/screens/compareTastes.dart';
import 'package:what_do_i_like/ui/screens/myListMovies.dart';
import 'package:what_do_i_like/ui/screens/searchMovies.dart';
import 'package:what_do_i_like/ui/widget/customSizedBox.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text('What Do I Like?', textAlign: TextAlign.center),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _goToSearchMovies(context),
              child: const Text('Rechercher des films'),
            ),
            const H(20),
            ElevatedButton(
              onPressed: () => _goToMyListMovies(context),
              child: const Text('Voir mes films préférés'),
            ),
            const H(20),
            ElevatedButton(
              onPressed: () => _goToCompareTastes(context),
              child: const Text('Comparer mes goûts'),
            ),
          ],
        ),
      ),
    );
  }

  void _goToSearchMovies(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchMoviesScreen()));
  }

  void _goToMyListMovies(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const MyListMoviesScreen()));
  }

  void _goToCompareTastes(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const CompareTastesScreen()));
  }
}

//Landmark: 1. Do slides for workshop.