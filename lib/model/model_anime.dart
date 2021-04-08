// To parse this JSON data, do
//
//     final modelAnime = modelAnimeFromJson(jsonString);

import 'dart:convert';

ModelAnime modelAnimeFromJson(String str) =>
    ModelAnime.fromJson(json.decode(str));

String modelAnimeToJson(ModelAnime data) => json.encode(data.toJson());

class ModelAnime {
  ModelAnime({
    this.malId,
    this.url,
    this.title,
    this.imageUrl,
    this.synopsis,
    this.type,
    this.airingStart,
    this.episodes,
    this.members,
    this.genres,
    this.source,
    this.producers,
    this.score,
    this.licensors,
    this.r18,
    this.kids,
  });

  int malId;
  String url;
  String title;
  String imageUrl;
  String synopsis;
  String type;
  String airingStart;
  int episodes;
  int members;
  List<Genre> genres;
  String source;
  List<Genre> producers;
  double score;
  List<String> licensors;
  bool r18;
  bool kids;

  factory ModelAnime.fromJson(Map<String, dynamic> json) => ModelAnime(
        malId: json["mal_id"],
        url: json["url"],
        title: json["title"],
        imageUrl: json["image_url"],
        synopsis: json["synopsis"],
        type: json["type"],
        airingStart: json["airing_start"],
        episodes: json["episodes"],
        members: json["members"],
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        source: json["source"],
        producers:
            List<Genre>.from(json["producers"].map((x) => Genre.fromJson(x))),
        score: json["score"].toDouble(),
        licensors: List<String>.from(json["licensors"].map((x) => x)),
        r18: json["r18"],
        kids: json["kids"],
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "url": url,
        "title": title,
        "image_url": imageUrl,
        "synopsis": synopsis,
        "type": type,
        "airing_start": airingStart,
        "episodes": episodes,
        "members": members,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "source": source,
        "producers": List<dynamic>.from(producers.map((x) => x.toJson())),
        "score": score,
        "licensors": List<dynamic>.from(licensors.map((x) => x)),
        "r18": r18,
        "kids": kids,
      };
}

class Genre {
  Genre({
    this.malId,
    this.type,
    this.name,
    this.url,
  });

  int malId;
  String type;
  String name;
  String url;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        malId: json["mal_id"],
        type: json["type"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "type": type,
        "name": name,
        "url": url,
      };
}
