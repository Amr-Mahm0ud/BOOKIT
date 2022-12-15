import 'dart:convert';

VideoModel videoModelFromJson(String str) =>
    VideoModel.fromJson(json.decode(str));

String videoModelToJson(VideoModel data) => json.encode(data.toJson());

class VideoModel {
  VideoModel({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  String? iso6391;
  String? iso31661;
  String? name;
  String? key;
  String? site;
  int? size;
  String? type;
  bool? official;
  DateTime? publishedAt;
  String? id;

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        iso6391: json["iso_639_1"] ?? '',
        iso31661: json["iso_3166_1"] ?? '',
        name: json["name"] ?? '',
        key: json["key"] ?? '',
        site: json["site"] ?? '',
        size: json["size"] ?? 0,
        type: json["type"] ?? '',
        official: json["official"] ?? false,
        publishedAt:
            DateTime.parse(json["published_at"] ?? '2014-10-02T19:20:22.000Z'),
        id: json["id"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "iso_639_1": iso6391,
        "iso_3166_1": iso31661,
        "name": name,
        "key": key,
        "site": site,
        "size": size,
        "type": type,
        "official": official,
        "published_at": publishedAt!.toIso8601String(),
        "id": id,
      };
}
