import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modul3/kelompok.dart';
import 'dart:convert';

import 'detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Show>> shows;
  late Future<List<Manga>> mangas;

  @override
  void initState() {
    super.initState();
    shows = fetchShows();
    mangas = fetchMangas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Anime List'),
        actions: [
          IconButton(
            onPressed: ()=>Navigator.push(context, 
            MaterialPageRoute(builder: (context)=>KelompokPage())), 
            icon: Icon(Icons.arrow_forward))
        ],
        ),
      body: Column(
          children: [
            SizedBox(height: 10),
            Text('Top Manga List',style: 
            TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),),
            FutureBuilder(
                builder: (context, AsyncSnapshot<List<Manga>> snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () => 
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                        item: snapshot.data![index].malId,
                                        title: snapshot.data![index].title,
                                        score: snapshot.data![index].score,
                                        image: snapshot.data![index].images.jpg.image_url,
                                        synopsis: snapshot.data![index].synopsis,),
                                    
                                  ),
                                ),
                              child: Container(
                              padding: const EdgeInsets.only(top: 30, left: 24),
                              width: 150,
                              height: 150,
                              child: Column(
                                children: [
                                                      ClipRRect(
                              borderRadius: BorderRadius.circular(21),
                              child: Image.network(
                                snapshot.data![index].images.jpg.image_url,
                                height: 200,
                              ),
                                                      ),
                                                      const SizedBox(
                              height: 20,
                                                      ),
                                                      Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data![index].title,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        snapshot.data![index].score.toString(),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                            );
                  },
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('${snapshot.error}'));
                  }
                  return const CircularProgressIndicator();
                },
                future: mangas,
              ),
            Text('Top Anime List',style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 20,),
              FutureBuilder(
                builder: (context, AsyncSnapshot<List<Show>> snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    snapshot.data![index].images.jpg.image_url),
                              ),
                              title: Text(snapshot.data![index].title),
                              subtitle: Text('Score: ${snapshot.data![index].score}'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                        item: snapshot.data![index].malId,
                                        title: snapshot.data![index].title,
                                        score: snapshot.data![index].score,
                                        image: snapshot.data![index].images.jpg.image_url,
                                        synopsis: snapshot.data![index].synopsis,),
                                    
                                  ),

                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('${snapshot.error}'));
                  }
                  return const CircularProgressIndicator();
                },
                future: shows,
              ),
          ],
        ),
    );
  }
}

class Show {
  final int malId;
  final String title;
  Images images;
  final num score;
  final String synopsis;

  Show({
    required this.malId,
    required this.title,
    required this.images,
    required this.score,
    required this.synopsis,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      malId: json['mal_id'],
      title: json['title'],
      images: Images.fromJson(json['images']),
      score: json['score'],
      synopsis: json['synopsis']
    );
  }

  Map<String, dynamic> toJson() => {
        'mal_id': malId,
        'title': title,
        'images': images,
        'score': score,
        'synopsis': synopsis
      };
}

class Images {
  final Jpg jpg;

  Images({required this.jpg});
  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      jpg: Jpg.fromJson(json['jpg']),
    );
  }

  Map<String, dynamic> toJson() => {
        'jpg': jpg.toJson(),
      };
}

class Jpg {
  String image_url;
  String small_image_url;
  String large_image_url;

  Jpg({
    required this.image_url,
    required this.small_image_url,
    required this.large_image_url,
  });

  factory Jpg.fromJson(Map<String, dynamic> json) {
    return Jpg(
      image_url: json['image_url'],
      small_image_url: json['small_image_url'],
      large_image_url: json['large_image_url'],
    );
  }
  //to json
  Map<String, dynamic> toJson() => {
        'image_url': image_url,
        'small_image_url': small_image_url,
        'large_image_url': large_image_url,
      };
}

Future<List<Show>> fetchShows() async {
  final response =
      await http.get(Uri.parse('https://api.jikan.moe/v4/top/anime'));

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body)['data'] as List;
    return jsonResponse.map((show) => Show.fromJson(show)).toList();
  } else {
    throw Exception('Failed to load shows');
  }
}

class Manga {
  final int malId;
  final String title;
  Images images;
  final num score;
  final String synopsis;

  Manga({
    required this.malId,
    required this.title,
    required this.images,
    required this.score,
    required this.synopsis,
  });

  factory Manga.fromJson(Map<String, dynamic> json) {
    return Manga(
      malId: json['mal_id'],
      title: json['title'],
      images: Images.fromJson(json['images']),
      score: json['score'],
      synopsis: json['synopsis']
    );
  }

  Map<String, dynamic> toJson() => {
        'mal_id': malId,
        'title': title,
        'images': images,
        'score': score,
        'synopsis': synopsis
      };
}

Future<List<Manga>> fetchMangas() async {
  final response =
      await http.get(Uri.parse('https://api.jikan.moe/v4/top/manga'));

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body)['data'] as List;
    return jsonResponse.map((manga) => Manga.fromJson(manga)).toList();
  } else {
    throw Exception('Failed to load mangas');
  }
}

