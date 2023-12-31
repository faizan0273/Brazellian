class Event {
  final String id;
  final String userId;
  final String title;
  final String description;
  final List<String> keywords;
  final String date;
  final String time;
  final String start;
  final String end;
  final String local;
  final String postalCode;
  final String website;
  final String instagram;
  final String facebook;
  final String thumbnail;
  final List<String> multiplePictures;
  final int v;

  Event({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.keywords,
    required this.date,
    required this.time,
    required this.start,
    required this.end,
    required this.local,
    required this.postalCode,
    required this.website,
    required this.instagram,
    required this.facebook,
    required this.thumbnail,
    required this.multiplePictures,
    required this.v,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['_id'] ?? "",
      userId: json['userId'] ?? "",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      keywords: List<String>.from(json['keywords'] ?? []),
      date: json['date'] ?? "",
      time: json['time'] ?? "",
      start: json['start'] ?? "",
      end: json['end'] ?? "",
      local: json['local'] ?? "",
      postalCode: json['postalCode'] ?? "",
      website: json['website'] ?? "",
      instagram: json['instagram'] ?? "",
      facebook: json['facebook'] ?? "",
      thumbnail: json['thumbnail'] ?? "",
      multiplePictures: List<String>.from(json['multiplePictures'] ?? []),
      v: json['__v'] ?? 0,
    );
  }

}

class EventsResponse {
  final List<Event>? events;
  EventsResponse({ this.events});
  factory EventsResponse.fromJson(Map<String, dynamic> json) {
    return EventsResponse(
      events: List<Event>.from(json['events'].map((event) => Event.fromJson(event))),
    );
  }
}
