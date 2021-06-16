import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:itg_task/constants/size_config.dart';
import 'package:itg_task/constants/styles.dart';
import 'package:itg_task/services/network.dart';

class CharacterOverview extends StatelessWidget {
  final int? id;
  final String? name;
  final String? description;
  final String? image;
  final int? totalComics;
  final int? totalSeries;
  final int? totalStories;
  final int? totalEvents;

  CharacterOverview(
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
    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                image!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'NAME',
                    style: redTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: Text(
                    '$name',
                    style: boldStandardTextStyle,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'DESCRIPTION',
                    style: redTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: Text(
                    '$description',
                    style: boldStandardTextStyle,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                  child: Text(
                    'COMICS',
                    style: redTextStyle,
                  ),
                ),
                Container(
                  height: 170,
                  child: FutureBuilder<List<dynamic>>(
                      future: getComics(id!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (ctx, index) {
                              return Container(
                                width: 100,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 120,
                                      width: 80,
                                      child: Image.network(
                                        snapshot.data![index]['thumbnail']['path'] +
                                            '/standard_fantastic.' +
                                            snapshot.data![index]['thumbnail']['extension'],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data![index]['title'],
                                      style: standardTextStyle,
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                  child: Text(
                    'SERIES',
                    style: redTextStyle,
                  ),
                ),
                Container(
                  height: 170,
                  child: FutureBuilder<List<dynamic>>(
                      future: getSeries(id!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (ctx, index) {
                              return Container(
                                width: 100,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 120,
                                      width: 80,
                                      child: Image.network(
                                        snapshot.data![index]['thumbnail']['path'] +
                                            '/standard_fantastic.' +
                                            snapshot.data![index]['thumbnail']['extension'],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data![index]['title'],
                                      style: standardTextStyle,
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                  child: Text(
                    'STORIES',
                    style: redTextStyle,
                  ),
                ),
                Container(
                  height: 170,
                  child: FutureBuilder<List<dynamic>>(
                      future: getStories(id!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (ctx, index) {
                              if (snapshot.data![index]['thumbnail'] == null) {
                                return Container(
                                  width: 100,
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 120,
                                          width: 80,
                                          child: Image.asset(
                                            'assets/No_Image.png',
                                            fit: BoxFit.fitWidth,
                                          )),
                                      Text(
                                        snapshot.data![index]['title'],
                                        style: standardTextStyle,
                                        textAlign: TextAlign.center,
                                        maxLines: 3,
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return Container(
                                width: 100,
                                child: Column(
                                  children: [
                                    Container(
                                        height: 120,
                                        width: 80,
                                        child: Image.network(
                                          snapshot.data![index]['thumbnail']['path'] +
                                              '/standard_fantastic.' +
                                              snapshot.data![index]['thumbnail']['extension'],
                                          fit: BoxFit.fill,
                                        )),
                                    Text(
                                      snapshot.data![index]['title'],
                                      style: standardTextStyle,
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                  child: Text(
                    'EVENTS',
                    style: redTextStyle,
                  ),
                ),
                Container(
                  height: 170,
                  child: FutureBuilder<List<dynamic>>(
                      future: getEvents(id!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (ctx, index) {
                              return Container(
                                width: 100,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 120,
                                      width: 80,
                                      child: Image.network(
                                        snapshot.data![index]['thumbnail']['path'] +
                                            '/standard_fantastic.' +
                                            snapshot.data![index]['thumbnail']['extension'],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data![index]['title'],
                                      style: standardTextStyle,
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                  child: Text(
                    'RELATED LINKS',
                    style: redTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: SizeConfig.screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Detail',
                            style: bigStandardTextStyle,
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: SizeConfig.screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Wiki',
                            style: bigStandardTextStyle,
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: SizeConfig.screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Comiclink',
                            style: bigStandardTextStyle,
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
