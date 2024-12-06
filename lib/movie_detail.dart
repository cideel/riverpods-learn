import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpods_learning/Model/movie.dart';
import 'package:riverpods_learning/api.dart';

class MovieDetailScreen extends ConsumerWidget {
  final int movieId;
  final Movie movie;

  const MovieDetailScreen(
      {Key? key, required this.movieId, required this.movie})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String posterUrl = 'https://image.tmdb.org/t/p/w500${movie.backpath}';
    final movieDetail = ref.watch(movieDetailProvider(movieId));

    return SafeArea(
      child: ScreenUtilInit(
        designSize: Size(375, 854),
        builder: (context, child) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            centerTitle: true,
            backgroundColor: Colors.black,
            title: Text(
              movie.title,
              style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 35.h,
                ),
                Container(
                  height: 200.h,
                  width: 1.sw,
                  child: Image.network(
                    posterUrl,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: 35.h,
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    movie.title,
                    style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        movie.releaseDate?.substring(0, 4) ?? '',
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal),
                      ),
                      dividerWidget(),
                      Text(
                        movie.language.toUpperCase(),
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal),
                      ),
                      dividerWidget(),
                      Text(
                        movie.rating.toStringAsFixed(1),
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal),
                      ),
                      dividerWidget(),
                      Text(
                        movie.popularity.toString(),
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "  LIKES",
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    movie.overview,
                    style:
                        GoogleFonts.inter(color: Colors.white, fontSize: 12.sp),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                movieDetail.when(
                  data: (movie) {
                    int runtime = movie.runtime;
                    String studio = movie.studio
                        .map((company) => company['name'])
                        .join(', ');
                    String genres =
                        movie.genres.map((genre) => genre['name']).join(', ');
                    String starring = movie.cast
                        .take(5)
                        .map((actor) => actor['name'])
                        .join(', ');
                    List<String> actorNames = movie.cast
                        .take(5)
                        .map((actor) => actor['name'] as String)
                        .toList();
                    List<String> characterNames = movie.cast
                        .take(5)
                        .map((actor) => actor['character'] as String)
                        .toList();
                    List<String> profileUrls = movie.cast
                        .take(5)
                        .map((actor) => actor['profile_path'] != null
                            ? 'https://image.tmdb.org/t/p/w500${actor['profile_path']}'
                            : 'https://via.placeholder.com/500')
                        .toList();
                    return Container(
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.symmetric(horizontal: 10.h),
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              margin: EdgeInsets.symmetric(horizontal: 5.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                    List.generate(actorNames.length, (index) {
                                  return Row(
                                    children: [
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Container(
                                        alignment: Alignment.bottomLeft,
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 70.w,
                                              height: 70.w,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white24),
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          profileUrls[index]),
                                                      fit: BoxFit.cover),
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Container(
                                              width: 75.w,
                                              child: Text(
                                                softWrap: true,
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                actorNames[index],
                                                style: GoogleFonts.inter(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Container(
                                              width: 75.w,
                                              child: Text(
                                                softWrap: true,
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                characterNames[index],
                                                style: GoogleFonts.inter(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Genre : $genres",
                              style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Runtime : $runtime Minutes",
                              style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Studio : $studio  ",
                              style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  error: (error, stackTrace) =>
                      Center(child: Text('Error: $error')),
                  loading: () => Center(child: CircularProgressIndicator()),
                ),
                Text("data")
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class dividerWidget extends StatelessWidget {
  const dividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "  |  ",
      style: GoogleFonts.inter(
          color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.normal),
    );
  }
}
