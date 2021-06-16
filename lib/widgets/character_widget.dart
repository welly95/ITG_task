import 'package:flutter/material.dart';
import 'package:itg_task/constants/size_config.dart';

import '../screens/character_overview.dart';

class CharacterWidget extends StatelessWidget {
  final int? id;
  final String? name;
  final String? description;
  final String? image;
  final int? totalComics;
  final int? totalSeries;
  final int? totalStories;
  final int? totalEvents;

  CharacterWidget(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.totalComics,
      this.totalSeries,
      this.totalStories,
      this.totalEvents});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => CharacterOverview(
              id: id,
              name: name,
              description: description,
              image: image,
              totalComics: totalComics,
              totalSeries: totalSeries,
              totalStories: totalStories,
              totalEvents: totalEvents,
            ),
          ),
        );
      },
      child: Container(
        height: SizeConfig.screenHeight! * 0.25,
        child: Stack(
          children: [
            Image.network(
              image!,
              width: SizeConfig.screenWidth,
              fit: BoxFit.fitWidth,
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                child: Stack(
                  children: [
                    CustomPaint(
                      size: Size(
                        SizeConfig.screenWidth! * 0.6,
                        SizeConfig.screenHeight! * 0.1,
                      ),
                      painter: RPSCustomPainter(),
                    ),
                    Positioned(
                      left: SizeConfig.screenWidth! * 0.15,
                      bottom: SizeConfig.screenHeight! * 0.035,
                      child: Center(
                        child: Text(
                          name!,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = 15.5;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.8763333, size.height * 0.2848571);
    path_0.lineTo(size.width * 0.1658333, size.height * 0.2871429);
    path_0.lineTo(size.width * 0.0803333, size.height * 0.7840000);
    path_0.lineTo(size.width * 0.7911667, size.height * 0.7842857);

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
