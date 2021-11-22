import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_movie_task/config/config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class Detail extends StatefulWidget {
  final int id;

  const Detail({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final String apiKey = Config.apiKey;
  final String baseUrl = Config.baseUrl;
  final String baseImageUrl = Config.baseImageUrl;

  fetch(ApiType type) async {
    String computedUrl = '';
    switch (type) {
      case ApiType.credits:
        computedUrl = '$baseUrl/${widget.id}/credits?api_key=$apiKey';
        break;
      case ApiType.reviews:
        computedUrl = '$baseUrl/${widget.id}/reviews?api_key=$apiKey';
        break;
      default:
        computedUrl = '$baseUrl/${widget.id}?api_key=$apiKey';
    }
    var uri = Uri.parse(computedUrl);
    var response = await http.get(uri);
    var decodeResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    return decodeResponse;
  }

  Widget voteAverageToStars(double score) {
    return Row(
        children: List.generate(5, (index) {
      return Padding(
        padding: const EdgeInsets.only(right: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svgs/Star.svg',
              color: score >= index * 2
                  ? const Color(0xFFF1C644)
                  : const Color(0xFFC4C4C4),
            ),
            if (index == 4)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  score.toString(),
                  style:
                      const TextStyle(fontSize: 12, color: Color(0xffF1C644)),
                ),
              )
          ],
        ),
      );
    }));
  }

  Widget reviewCard(dynamic data, double width) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Container(
          padding: const EdgeInsets.all(8.0),
          width: width - 32,
          height: 75,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 4.0,
              ),
            ],
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(data['content'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12)),
              Text(
                data['author'],
                style: const TextStyle(fontSize: 12, color: Color(0xFFA1A1A1)),
              )
            ],
          )),
    );
  }

  String computedGenreList(List genreList) {
    String result = '';
    genreList.asMap().forEach((index, element) {
      result = result +
          genreIdToName(element['id']) +
          ((index == genreList.length - 1) ? '' : ', ');
    });
    return result;
  }

  String genreIdToName(int id) {
    switch (id) {
      case 28:
        return 'Action';
      case 12:
        return 'Adventure';
      case 16:
        return 'Animation';
      case 35:
        return 'Comedy';
      case 80:
        return 'Crime';
      case 99:
        return 'Documentary';
      case 18:
        return 'Drama';
      case 10751:
        return 'Family';
      case 14:
        return 'Fantasy';
      case 36:
        return 'History';
      case 27:
        return 'Horror';
      case 10402:
        return 'Music';
      case 9648:
        return 'Mystery';
      case 10749:
        return 'Romance';
      case 878:
        return 'Science Fiction';
      case 10770:
        return 'TV Movie';
      case 53:
        return 'Thriller';
      case 10752:
        return 'War';
      case 37:
        return 'Western';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: FutureBuilder<dynamic>(
          future: fetch(ApiType.none),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return snapshot.hasData
                ? Stack(
                    children: [
                      SizedBox(
                        width: _screenWidth,
                        height: _screenHeight,
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.6),
                                  BlendMode.dstATop),
                              child: Image.network(
                                '$baseImageUrl/${snapshot.data['backdrop_path']}',
                                height: 297,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16.0),
                                    topRight: Radius.circular(16.0)),
                                color: Colors.white,
                              ),
                              transform:
                                  Matrix4.translationValues(0.0, -90.0, 0.0),
                              child: Container(
                                transform:
                                    Matrix4.translationValues(0.0, -51.0, 0.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                '$baseImageUrl/${snapshot.data['backdrop_path']}',
                                                width: 104,
                                                height: 159,
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16.0),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 50,
                                            ),
                                            Text(
                                              snapshot.data['original_title'],
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                            const SizedBox(height: 4),
                                            Container(
                                              width: 27,
                                              height: 12,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color:
                                                      const Color(0xffF66060),
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(2.0),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'Adult',
                                                  style: TextStyle(
                                                      fontSize: 7,
                                                      color: Color(0xffF66060)),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              computedGenreList(
                                                  snapshot.data['genres']),
                                              style: const TextStyle(
                                                  fontSize: 9,
                                                  color: Color(0xFF9A9A9A)),
                                            ),
                                            const SizedBox(height: 4.0),
                                            Text(
                                              snapshot.data['release_date'],
                                              style: const TextStyle(
                                                  fontSize: 9,
                                                  color: Color(0xFF9A9A9A)),
                                            ),
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                            voteAverageToStars(snapshot
                                                .data['vote_average']
                                                .toDouble()),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 16.0),
                                      child: Text(
                                        '개요',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                      ),
                                      child: Text(snapshot.data['overview']),
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 16.0),
                                      child: Text(
                                        '주요 출연진',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    SizedBox(
                                      width: _screenWidth,
                                      height: 54,
                                      child: FutureBuilder<dynamic>(
                                          future: fetch(ApiType.credits),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<dynamic> snapshot) {
                                            return snapshot.hasData
                                                ? ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        snapshot.data.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 17,
                                                                left: index == 0
                                                                    ? 16
                                                                    : 0),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              width: 40,
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                image:
                                                                    DecorationImage(
                                                                  image: NetworkImage(
                                                                      '$baseImageUrl/${snapshot.data['cast'][index]['profile_path']}'),
                                                                  fit: BoxFit
                                                                      .fitWidth,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 2.0,
                                                            ),
                                                            SizedBox(
                                                              width: 54,
                                                              child: Text(
                                                                  snapshot.data[
                                                                              'cast']
                                                                          [index]
                                                                      [
                                                                      'original_name'],
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          8,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center),
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : Container();
                                          }),
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    FutureBuilder<dynamic>(
                                        future: fetch(ApiType.reviews),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<dynamic> snapshot) {
                                          return snapshot.hasData
                                              ? snapshot.data['results'] != null
                                                  ? Column(
                                                      children: [
                                                        Column(
                                                          children: List.generate(
                                                              snapshot
                                                                  .data[
                                                                      'results']
                                                                  .length,
                                                              (index) {
                                                            return Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                if (index == 0)
                                                                  const Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                16.0),
                                                                    child: Text(
                                                                      '리뷰',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16.0,
                                                                          fontWeight:
                                                                              FontWeight.w700),
                                                                    ),
                                                                  ),
                                                                const SizedBox(
                                                                    height:
                                                                        16.0),
                                                                reviewCard(
                                                                    snapshot.data[
                                                                            'results']
                                                                        [index],
                                                                    _screenWidth),
                                                              ],
                                                            );
                                                          }),
                                                        ),
                                                      ],
                                                    )
                                                  : Container()
                                              : Container();
                                        })
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0.0,
                        ),
                      ),
                    ],
                  )
                : Container();
          }),
    );
  }
}

enum ApiType { credits, reviews, none }
