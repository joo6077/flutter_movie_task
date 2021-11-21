// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String apiKey = '04959d38722820bec95208db53060316';
  final String baseUrl = 'https://api.themoviedb.org/3/movie';
  final String baseImageUrl = 'https://image.tmdb.org/t/p/original';
  final String nowPlaying = 'now_playing';
  final List<Map<String, String>> urlTitleList = [
    {'url': 'upcoming', 'title': '개봉 예정'},
    {'url': 'popular', 'title': '인기'},
    {'url': 'top_rated', 'title': '높은 평점'},
  ];

  @override
  void initState() {
    super.initState();
  }

  fetch(String url) async {
    var nowPlayingUrl = Uri.parse('$baseUrl/$url?api_key=$apiKey');
    var response = await http.get(nowPlayingUrl);
    var decodeResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    inspect(decodeResponse['results'][0]);
    return decodeResponse['results'];
  }

  Widget voteAverageToStars(double score) {
    return Row(
        children: List.generate(5, (index) {
      return Padding(
        padding: EdgeInsets.only(left: index != 0 ? 4 : 0),
        child: SvgPicture.asset(
          'assets/svgs/Star.svg',
          color: score >= index * 2
              ? const Color(0xFFF1C644)
              : const Color(0xFFC4C4C4),
        ),
      );
    }));
  }

  Widget nowPlayingWidget(dynamic data) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            '$baseImageUrl/${data['backdrop_path']}',
            width: 104,
            height: 159,
            fit: BoxFit.fitHeight,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        SizedBox(
          width: 104,
          child: Text(
            data['original_title'],
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        voteAverageToStars(data['vote_average'].toDouble()),
      ],
    );
  }

  Widget basicListItemWidget(dynamic data, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              '$baseImageUrl/${data['backdrop_path']}',
              width: 45,
              height: 69,
              fit: BoxFit.fitHeight,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data['original_title'],
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(
                height: 4,
              ),
              voteAverageToStars(data['vote_average'].toDouble()),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: screenWidth - 48 - 45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      computedGenreList(data['genre_ids']),
                      style: const TextStyle(
                          fontSize: 9, color: Color(0xFF9A9A9A)),
                    ),
                    Text(
                      data['release_date'],
                      style: const TextStyle(
                          fontSize: 9, color: Color(0xFF9A9A9A)),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  String computedGenreList(List genreList) {
    String result = '';
    genreList.asMap().forEach((index, element) {
      result = result +
          genreIdToName(element) +
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

  Widget listForm(
      {required Map<String, String> titleWithURL, required double width}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            titleWithURL['title']!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        FutureBuilder<dynamic>(
            future: fetch(titleWithURL['url']!),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return snapshot.hasData
                  ? Column(
                      children: [
                        basicListItemWidget(snapshot.data[0], width),
                        const SizedBox(
                          height: 8,
                        ),
                        basicListItemWidget(snapshot.data[1], width),
                        const SizedBox(
                          height: 8,
                        ),
                        basicListItemWidget(snapshot.data[2], width),
                      ],
                    )
                  : Container();
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                '현재 상영중',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: _screenWidth,
              height: 196,
              child: FutureBuilder<dynamic>(
                  future: fetch(nowPlaying),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    return snapshot.hasData
                        ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    right: 17, left: index == 0 ? 16 : 0),
                                child: nowPlayingWidget(snapshot.data[index]),
                              );
                            },
                          )
                        : Container();
                  }),
            ),
            const SizedBox(height: 16),
            for (var urlTitle in urlTitleList)
              listForm(titleWithURL: urlTitle, width: _screenWidth)
          ],
        ),
      ),
    );
  }
}
