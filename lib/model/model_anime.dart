// To parse this JSON data, do
//
//     final modelAnime = modelAnimeFromJson(jsonString);

import 'dart:convert';

ModelAnime modelAnimeFromJson(String str) =>
    ModelAnime.fromJson(json.decode(str));

String modelAnimeToJson(ModelAnime data) => json.encode(data.toJson());

class ModelAnime {
  ModelAnime({
    this.requestHash,
    this.requestCached,
    this.requestCacheExpiry,
    this.malUrl,
    this.itemCount,
    this.anime,
  });

  String requestHash;
  bool requestCached;
  int requestCacheExpiry;
  MalUrl malUrl;
  int itemCount;
  List<Anime> anime;

  factory ModelAnime.fromJson(Map<String, dynamic> json) => ModelAnime(
        requestHash: json["request_hash"],
        requestCached: json["request_cached"],
        requestCacheExpiry: json["request_cache_expiry"],
        malUrl: MalUrl.fromJson(json["mal_url"]),
        itemCount: json["item_count"],
        anime: List<Anime>.from(json["anime"].map((x) => Anime.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "request_hash": requestHash,
        "request_cached": requestCached,
        "request_cache_expiry": requestCacheExpiry,
        "mal_url": malUrl.toJson(),
        "item_count": itemCount,
        "anime": List<dynamic>.from(anime.map((x) => x.toJson())),
      };
}

class Anime {
  Anime({
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
    this.score,
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
  List<MalUrl> genres;
  String source;
  double score;
  bool r18;
  bool kids;

  factory Anime.fromJson(Map<String, dynamic> json) => Anime(
        malId: json["mal_id"],
        url: json["url"],
        title: json["title"],
        imageUrl: json["image_url"],
        synopsis: json["synopsis"],
        type: json["type"],
        airingStart: json["airing_start"],
        episodes: json["episodes"],
        members: json["members"],
        genres:
            List<MalUrl>.from(json["genres"].map((x) => MalUrl.fromJson(x))),
        source: json["source"],
        score: json["score"].toDouble(),
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
        "score": score,
        "r18": r18,
        "kids": kids,
      };
}

class MalUrl {
  MalUrl({
    this.malId,
    this.type,
    this.name,
    this.url,
  });

  int malId;
  String type;
  String name;
  String url;

  factory MalUrl.fromJson(Map<String, dynamic> json) => MalUrl(
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
