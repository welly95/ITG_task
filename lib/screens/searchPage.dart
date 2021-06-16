import 'package:flutter/material.dart';
import 'package:itg_task/constants/size_config.dart';
import 'package:itg_task/constants/styles.dart';
import 'package:itg_task/services/network.dart';

import 'character_overview.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController heroName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: SizeConfig.screenHeight! * 0.05,
          child: Center(
            child: TextField(
              controller: heroName,
              onChanged: (val) {
                setState(() {
                  heroName.text = val;
                  heroName.selection = TextSelection.fromPosition(TextPosition(offset: heroName.text.length));
                });
              },
              style: searchTextStyle,
              textAlignVertical: TextAlignVertical.center,
              cursorHeight: 16,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(8.0),
                  ),
                  borderSide: BorderSide(color: Colors.transparent, width: 0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(8.0),
                  ),
                  borderSide: BorderSide(color: Colors.transparent, width: 0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(8.0),
                  ),
                  borderSide: BorderSide(color: Colors.transparent, width: 0),
                ),
                filled: true,
                hintStyle: searchTextStyle.copyWith(color: Colors.grey),
                hintText: "Search...",
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
        actions: [
          Container(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: redTextStyle.copyWith(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: searchingHero(heroName.text),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, index) {
                if (snapshot.data![index]['thumbnail']['path'].contains('image_not_available') == true) {
                  return Container();
                }
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => CharacterOverview(
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
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: Row(
                      children: [
                        Container(
                          height: SizeConfig.screenHeight! * 0.15,
                          width: SizeConfig.screenWidth! * 0.25,
                          child: Image.network(
                              snapshot.data![index]['thumbnail']['path'] +
                                  '/standard_fantastic.' +
                                  snapshot.data![index]['thumbnail']['extension'],
                              fit: BoxFit.cover),
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth! * 0.05,
                        ),
                        FittedBox(
                            child: Container(
                          width: SizeConfig.screenWidth! * 0.6,
                          child: Text(
                            snapshot.data![index]['name'],
                            overflow: TextOverflow.clip,
                            maxLines: 3,
                          ),
                        )),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.red[700],
                ),
              );
            }
            return Center(
                child: Text(
              'There isn\'t any data here',
              style: redTextStyle,
            ));
          }
        },
      ),
    );
  }
}
