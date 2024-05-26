import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:what_do_i_like/api/api.dart';
import 'package:what_do_i_like/models/movie.dart';
import 'package:what_do_i_like/ui/widget/customSizedBox.dart';

class SearchMoviesScreen extends StatefulWidget {
  const SearchMoviesScreen({Key? key}) : super(key: key);

  @override
  State<SearchMoviesScreen> createState() => _SearchMoviesScreenState();
}

class _SearchMoviesScreenState extends State<SearchMoviesScreen> {
  List<Movie> movies = [];

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const H(40),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "Entrer le nom d'un film",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () async {
                    await _searchMovieByName(context, controller.text);
                  },
                ),
              ),
            ),
            const H(20),
            Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  Movie movie = movies[index];
                  return Card(
                    child: ListTile(
                      title: Text(movie.title),
                      subtitle: Text('Note: ${movie.rated}'),
                      leading:
                          movie.image != null ? Image.network('https://image.tmdb.org/t/p/w500${movie.image!}') : null,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.info_outline),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(movie.title),
                                  content: Text(movie.overview ?? 'Pas de description'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: const Text('Close'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const W(10),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () async {
                              await _addMovie(movie.tmbdId);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*
  *    Fill list of movies
  */
  Future<void> _searchMovieByName(BuildContext context, String movieName) async {
    try {
      Response response = await ApiClient().getRequest('/search_movie', params: {'title': movieName});

      List<Movie> fetchedMovies =
          (response.data['results'] as List).map((movieJson) => Movie.fromJson(movieJson)).toList();
      setState(() => movies = fetchedMovies);
    } catch (e) {
      print('error: $e');
      _noMovieFound(context);
    }
  }

  /*
  *    Show snackbar when no movie found
  */
  void _noMovieFound(BuildContext context) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Film introuvable'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );

/*
*    Add movie to user list
*/
  Future<void> _addMovie(int tmdbId) async {
    try {
      if (ApiClient().userId != null) {
        var data = {'userId': ApiClient().userId, 'tmdbId': tmdbId};
        final response = await ApiClient().postRequest('/add_movie', data);
        if (response.statusCode == 201) {
          _showMessage('Movie added successfully', Colors.green);
        } else if (response.statusCode == 200) {
          _showMessage('Movie already exists for this user', Colors.red);
        } else {
          _showMessage('Failed to add movie', Colors.red);
        }
      } else {
        _showMessage('User ID not found', Colors.red);
      }
    } catch (e) {
      print('Error adding movie: $e');
      _showMessage('Failed to add movie', Colors.red);
    }
  }

  //TODO: factorise it
  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
