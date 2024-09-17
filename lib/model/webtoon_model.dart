class WebtoonModel {
  WebtoonModel({
      String? id, 
      String? title, 
      String? thumb, 
      String? thumb2,}){
    _id = id;
    _title = title;
    _thumb = thumb;
    _thumb2 = thumb2;
}

  WebtoonModel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _thumb = json['thumb'];
    _thumb2 = json['thumb2'];
  }
  String? _id;
  String? _title;
  String? _thumb;
  String? _thumb2;
WebtoonModel copyWith({  String? id,
  String? title,
  String? thumb,
  String? thumb2,
}) => WebtoonModel(  id: id ?? _id,
  title: title ?? _title,
  thumb: thumb ?? _thumb,
  thumb2: thumb2 ?? _thumb2,
);
  String? get id => _id;
  String? get title => _title;
  String? get thumb => _thumb;
  String? get thumb2 => _thumb2;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['thumb'] = _thumb;
    map['thumb2'] = _thumb2;
    return map;
  }

}