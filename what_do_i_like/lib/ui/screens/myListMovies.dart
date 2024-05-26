import 'package:flutter/material.dart';
import 'package:what_do_i_like/api/api.dart';
import 'package:what_do_i_like/models/movie.dart';

class MyListMoviesScreen extends StatelessWidget {
  const MyListMoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Movies'),
      ),
      body: FutureBuilder<List<Movie>>(
        future: _getUserMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No movies found for this user'));
          } else {
            List<Movie> movies = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  Movie movie = movies[index];
                  //TODO: factorise it
                  return Card(
                    child: ListTile(
                      title: Text(movie.title),
                      subtitle: Text('Note: ${movie.rated}'),
                      leading:
                          movie.image != null ? Image.network('https://image.tmdb.org/t/p/w500${movie.image!}') : null,
                      trailing: IconButton(
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
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  Future<List<Movie>> _getUserMovies() async {
    try {
      if (ApiClient().userId != null) {
        final response = await ApiClient().getRequest('/user_movies', params: {'user_id': ApiClient().userId});
        List<Movie> fetchedMovies = (response.data as List).map((movieJson) => Movie.fromJson(movieJson)).toList();
        return fetchedMovies;
      } else {
        throw Exception('User ID not found');
      }
    } catch (e) {
      print('Error fetching user movies: $e');
      throw Exception('Failed to load user movies');
    }
  }

  void _noMovieFound(BuildContext context) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Film introuvable'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
}
