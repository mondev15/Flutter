import 'package:flutter/material.dart';
import 'package:movies/http_helper.dart';
import 'package:movies/movie_detail.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  String result;
  HttpHelper helper;
  int moviesCount;
  List movies;
  final String iconBase = 'https://image.tmdb.org/t/p/w92';
  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-11884339.jpg';
  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;
    return Scaffold(
        appBar: AppBar(
          title: Text('Films'),
        ),
        body: ListView.builder(
            itemCount: (this.moviesCount == null) ? 0 : this.moviesCount,
            itemBuilder: (BuildContext context, int position) {
              if (movies[position].posterPath != null) {
                image = NetworkImage(iconBase + movies[position].posterPath);
              } else {
                image = NetworkImage(defaultImage);
              }
              return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                    onTap: () {
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (_) => MovieDetail(movies[position]));
                      Navigator.push(context, route);
                    },
                    leading: CircleAvatar(backgroundImage: image),
                    title: Text(movies[position].title),
                    subtitle: Text('Date de Sortie: ' +
                        movies[position].releaseDate +
                        ' - Vote: ' +
                        movies[position].voteAverage.toString()),
                  ));
            }));
  }

  Future initialize() async {
    movies = List();
    movies = await helper.getUpcoming();
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }
}