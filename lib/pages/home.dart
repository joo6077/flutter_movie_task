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

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(left: 16),
          children: [
            const Text(
              '현재 상영중',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: _screenWidth - 16,
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
                                padding: const EdgeInsets.only(right: 17),
                                child: nowPlayingWidget(snapshot.data[index]),
                              );
                            },
                          )
                        : Container();
                  }),
            ),
            const SizedBox(height: 40),
            const Text(
              '개봉 예정',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    '222397.jpg',
                    width: 45,
                    height: 69,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Moonlight Movie',
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/svgs/Star.svg'),
                        const SizedBox(
                          width: 5,
                        ),
                        SvgPicture.asset('assets/svgs/Star.svg'),
                        const SizedBox(
                          width: 5,
                        ),
                        SvgPicture.asset('assets/svgs/Star.svg'),
                        const SizedBox(
                          width: 5,
                        ),
                        SvgPicture.asset(
                          'assets/svgs/Star.svg',
                          color: const Color(0xFFC4C4C4),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SvgPicture.asset(
                          'assets/svgs/Star.svg',
                          color: const Color(0xFFC4C4C4),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: _screenWidth - 48 - 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Action, Drama',
                            style: TextStyle(
                                fontSize: 9, color: Color(0xFF9A9A9A)),
                          ),
                          Text(
                            '2016-08-03',
                            style: TextStyle(
                                fontSize: 9, color: Color(0xFF9A9A9A)),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
