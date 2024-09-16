class WebtoonModel {
  late String _id;
  late String _title;
  late String _thumb;

  String get id => _id;
  String get title => _title;
  String get thumb => _thumb;

  WebtoonModel({
    required String id,
    required String title,
    required String thumb,}){
    _id = id;
    _title = title;
    _thumb = thumb;
  }

  WebtoonModel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _thumb = json['thumb'];
  }

  WebtoonModel copyWith({ required String id,
    required String title,
    required String thumb,
  }) => WebtoonModel(  id: id ?? _id,
    title: title ?? _title,
    thumb: thumb ?? _thumb,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['thumb'] = _thumb;
    return map;
  }
}