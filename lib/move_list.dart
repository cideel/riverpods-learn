import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpods_learning/api.dart';
import 'package:riverpods_learning/movie_detail.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(movieListProvider);

    return SafeArea(
        child: ScreenUtilInit(
      designSize: Size(375, 854),
      builder: (context, child) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            "Favorites",
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        body: movies.when(
            data: (moviesList) => ListView.builder(
                  itemCount: moviesList.length,
                  itemBuilder: (context, index) {
                    final movie = moviesList[index];
                    return ListTile(
                      leading: Image.network(
                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        width: 50,
                      ),
                      title: Text(
                        movie.title,
                        style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      subtitle: Text(
                        movie.releaseDate?.substring(0, 4) ?? 'DONTKNOW',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                      ),
                      trailing: Text(
                        movie.rating.toStringAsFixed(1),
                        style: TextStyle(color: Colors.yellow, fontSize: 12.sp),
                      ),
                      onTap: () {
                        print("clicked bitch");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetailScreen(movieId: movie.id,movie: movie,)));
                      },
                    );
                  },
                ),
            error: (error, _) => Center(
                  child: Text('Error:$error'),
                ),
            loading: () => Center(
                  child: CircularProgressIndicator(),
                )),
      ),
    ));
  }
}
