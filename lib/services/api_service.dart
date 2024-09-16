// as < 왼쪽에 있는것에 이름을 붙일 수 있다
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:webtoon/model/webtoon_model.dart';

class ApiService {
  static const String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "/today";
  static const String userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36";

  /*
  * 통신이 완료 될때까지 await 로 멈추기
  * await 을 사용하기 위해선 async(비동기) 여야한다
  * Future 류에 타입에는 await 을 사용한다
  * */
  static Future<List<WebtoonModel>> getToDaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl$today');
    /*
    * Future<Response>  반환값
    * 미래에 받을 값의 타입을 알려줌
    * */
    final response = await http.get(url);

    if(response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);

      /*
        * 모델안에 리스트가 존재하면
        * 리스트 모델을 하나더 만들어서 같이 넣을것
        * ex)
        * 모델
        * late String _id;
        * late String _title;
        * late String _thumb;
        * late List<ListModel> listModel;
        *
        * 데이터 받기 예시
        * List<WebtoonListModel> webtoonListModel = []
        * for(var model in listModel)
        * {
        *   webtoonListModel.add(model);
        * }
        * */
      for(var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }

      return webtoonInstances;
    }

    throw Exception('Failed to load data');

  }
}