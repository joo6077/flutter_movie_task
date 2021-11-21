// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          '222397.jpg',
                          width: 104,
                          height: 159,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
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
                      )
                    ],
                  )
                ],
              ),
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
                  mainAxisAlignment: MainAxisAlignment.start,
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
