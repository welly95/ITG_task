import 'package:flutter/material.dart';
import 'package:itg_task/constants/size_config.dart';
import 'package:itg_task/screens/searchPage.dart';
import 'package:itg_task/services/network.dart';

import 'widgets/character_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    getCharacters();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Container(
          height: SizeConfig.screenHeight! * 0.06,
          width: SizeConfig.screenWidth! * 0.35,
          child: Image.asset(
            'assets/marvel_icon.jpg',
            fit: BoxFit.contain,
            width: SizeConfig.screenWidth! * 0.35,
          ),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchPage()));
            },
            child: Container(
              height: SizeConfig.screenHeight! * 0.06,
              width: SizeConfig.screenWidth! * 0.06,
              margin: EdgeInsets.only(right: 5),
              child: Image.asset('assets/search_icon.png'),
            ),
          )
        ],
      ),
      backgroundColor: Colors.black87,
      body: FutureBuilder<List<dynamic>>(
          future: getCharacters(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (ctx, index) {
                  if (snapshot.data![index]['thumbnail']['path'].contains('image_not_available') == true) {
                    return Container();
                  }
                  return CharacterWidget(
                    id: snapshot.data![index]['id'],
                    name: snapshot.data![index]['name'],
                    description: snapshot.data![index]['description'],
                    image: snapshot.data![index]['thumbnail']['path'] +
                        '/standard_fantastic.' +
                        snapshot.data![index]['thumbnail']['extension'],
                    totalComics: snapshot.data![index]['comics']['available'],
                    totalSeries: snapshot.data![index]['series']['available'],
                    totalStories: snapshot.data![index]['stories']['available'],
                    totalEvents: snapshot.data![index]['events']['available'],
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.red[700],
                ),
              );
            }
          }),
    );
  }
}
