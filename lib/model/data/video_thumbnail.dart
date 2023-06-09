class ThumbnailVideo {
    int count;
    dynamic next;
    dynamic previous;
    List<Result> results;

    ThumbnailVideo({
        required this.count,
        this.next,
        this.previous,
        required this.results,
    });

    factory ThumbnailVideo.fromJson(Map<String, dynamic> json) => ThumbnailVideo(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    int id;
    String name;
    String preview;
    Data data;

    Result({
        required this.id,
        required this.name,
        required this.preview,
        required this.data,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        preview: json["preview"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "preview": preview,
        "data": data.toJson(),
    };
}

class Data {
    String the480;
    String max;

    Data({
        required this.the480,
        required this.max,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        the480: json["480"],
        max: json["max"],
    );

    Map<String, dynamic> toJson() => {
        "480": the480,
        "max": max,
    };
}
