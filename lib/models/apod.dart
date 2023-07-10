class Apod {
  String copyright;
  String date;
  String display_date;
  String explanation;
  String hdurl;
  String media_type;
  String service_version;
  String title;
  String url;
  String favorite;

  Apod({
    required this.copyright,
    required this.date,
    required this.display_date,
    required this.explanation,
    required this.hdurl,
    required this.media_type,
    required this.service_version,
    required this.title,
    required this.url,
    this.favorite = 'no',
  });

  factory Apod.fromJson(Map<String, dynamic> json) => Apod(
        copyright: json["copyright"],
        date: json["date"],
        display_date: '',
        explanation: json["explanation"],
        hdurl: json["hdurl"],
        media_type: json["media_type"],
        service_version: json["service_version"],
        title: json["title"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "copyright": copyright,
        "date": date,
        "display_date": display_date,
        "explanation": explanation,
        "hdurl": hdurl,
        "media_type": media_type,
        "service_version": service_version,
        "title": title,
        "url": url,
      };
}
