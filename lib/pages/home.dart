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
                          SvgPicture.asset('assets/svgs/Star.svg'),
                          SvgPicture.asset('assets/svgs/Star.svg'),
                          SvgPicture.asset(
                            'assets/svgs/Star.svg',
                            color: const Color(0xFFC4C4C4),
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
            )
          ],
        ),
      ),
    );
  }
}
