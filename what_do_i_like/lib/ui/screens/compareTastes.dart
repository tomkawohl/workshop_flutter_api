import 'package:flutter/material.dart';
import 'package:what_do_i_like/api/api.dart';
import 'package:what_do_i_like/models/movie.dart';
import 'package:what_do_i_like/models/user.dart';

class CompareTastesScreen extends StatefulWidget {
  const CompareTastesScreen({Key? key}) : super(key: key);
  @override
  State<CompareTastesScreen> createState() => _CompareTastesStateScreen();
}

class _CompareTastesStateScreen extends State<CompareTastesScreen> {
  List<User> users = [];
  late int? userId;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare Tastes'),
      ),
      body: users.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                User user = users[index];
                return Card(
                  child: ListTile(
                    title: Text(user.username),
                    trailing: IconButton(
                      icon: const Icon(Icons.compare_arrows),
                      onPressed: userId != null ? () => _compareTastes(userId!, user.id) : null,
                    ),
                  ),
                );
              },
            ),
    );
  }

  Future<void> getData() async {
    await _fetchCurrentUserId();
    _fetchUsers();
  }

  Future<void> _fetchCurrentUserId() async {
    setState(() {
      userId = ApiClient().userId;
    });
  }

  Future<void> _fetchUsers() async {
    try {
      final response = await ApiClient().getRequest('/users', params: {'user_id': userId});
      List<User> fetchedUsers = (response.data as List).map((userJson) => User.fromJson(userJson)).toList();
      setState(() {
        users = fetchedUsers;
      });
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  Future<void> _compareTastes(int userId1, int userId2) async {
    try {
      final response = await ApiClient().postRequest('/compare_user_tastes', {
        'user_id1': userId1,
        'user_id2': userId2,
      });
      print('response.data: ${response.data}');
      double commonPercentage = (response.data['commonPercentage'] as num).toDouble();
      List<Movie> commonMovies =
          (response.data['commonMovies'] as List).map((movieJson) => Movie.fromJson(movieJson)).toList();
      _showComparisonResult(commonPercentage, commonMovies);
    } catch (e) {
      print('Error comparing tastes: $e');
      _showComparisonResult(null, []);
    }
  }

  void _showComparisonResult(double? percentage, List<Movie> commonMovies) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Comparison Result'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (percentage != null) ...[
              Text('Common Taste Percentage: ${percentage.toStringAsFixed(2)}%'),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: percentage / 100,
                backgroundColor: Colors.grey[300],
                color: Colors.green,
                minHeight: 10,
              ),
            ],
            if (commonMovies.isNotEmpty)
              SizedBox(
                height: 250,
                width: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: commonMovies.length,
                  itemBuilder: (context, index) {
                    final movie = commonMovies[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                      child: Column(
                        children: [
                          movie.image != null
                              ? Image.network('https://image.tmdb.org/t/p/w500${movie.image!}', width: 100)
                              : const SizedBox.shrink(),
                          Text(movie.title, textAlign: TextAlign.center),
                          Text('Rating: ${movie.rated}', textAlign: TextAlign.center),
                        ],
                      ),
                    );
                  },
                ),
              ),
            if (percentage == null) const Text('Failed to compare tastes.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
