class WebtoonEpisodeModel {
  WebtoonEpisodeModel({
      String? thumb, 
      String? id, 
      String? title, 
      String? rating, 
      String? date,}){
    _thumb = thumb;
    _id = id;
    _title = title;
    _rating = rating;
    _date = date;
}

  WebtoonEpisodeModel.fromJson(dynamic json) {
    _thumb = json['thumb'];
    _id = json['id'];
    _title = json['title'];
    _rating = json['rating'];
    _date = json['date'];
  }
  String? _thumb;
  String? _id;
  String? _title;
  String? _rating;
  String? _date;
WebtoonEpisodeModel copyWith({  String? thumb,
  String? id,
  String? title,
  String? rating,
  String? date,
}) => WebtoonEpisodeModel(  thumb: thumb ?? _thumb,
  id: id ?? _id,
  title: title ?? _title,
  rating: rating ?? _rating,
  date: date ?? _date,
);
  String? get thumb => _thumb;
  String? get id => _id;
  String? get title => _title;
  String? get rating => _rating;
  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['thumb'] = _thumb;
    map['id'] = _id;
    map['title'] = _title;
    map['rating'] = _rating;
    map['date'] = _date;
    return map;
  }

}