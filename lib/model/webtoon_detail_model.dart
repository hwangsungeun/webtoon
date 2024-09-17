class WebtoonDetailModel {
  WebtoonDetailModel({
      String? title, 
      String? about, 
      String? genre, 
      String? age, 
      String? thumb,}){
    _title = title;
    _about = about;
    _genre = genre;
    _age = age;
    _thumb = thumb;
}

  WebtoonDetailModel.fromJson(dynamic json) {
    _title = json['title'];
    _about = json['about'];
    _genre = json['genre'];
    _age = json['age'];
    _thumb = json['thumb'];
  }
  String? _title;
  String? _about;
  String? _genre;
  String? _age;
  String? _thumb;
WebtoonDetailModel copyWith({  String? title,
  String? about,
  String? genre,
  String? age,
  String? thumb,
}) => WebtoonDetailModel(  title: title ?? _title,
  about: about ?? _about,
  genre: genre ?? _genre,
  age: age ?? _age,
  thumb: thumb ?? _thumb,
);
  String? get title => _title;
  String? get about => _about;
  String? get genre => _genre;
  String? get age => _age;
  String? get thumb => _thumb;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['about'] = _about;
    map['genre'] = _genre;
    map['age'] = _age;
    map['thumb'] = _thumb;
    return map;
  }

}