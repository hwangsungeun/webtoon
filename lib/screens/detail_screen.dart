import 'package:flutter/material.dart';
import 'package:webtoon/model/webtoon_detail_model.dart';
import 'package:webtoon/model/webtoon_episode_model.dart';

import '../services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;


  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episode;

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episode = ApiService.getLatestEpisodesById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    /*
    * Scaffold 다른 페이지로 변결 될때 사용하자
    * */
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // leading: const BackButton(
        //   color: Colors.white,
        // ),
        elevation: 5,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.black,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(widget.title),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontSize: 25,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: widget.id,
                child: Container(
                  width: MediaQuery.of(context).size.width/2,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(10, 10),
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                        ),
                      ]
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(16)
                    ),
                    child: Image.network(
                      // height: 500,
                      // width: double.infinity,
                      widget.thumb,
                      fit: BoxFit.cover,
                      headers: const {
                        'User-Agent' : ApiService.userAgent
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          FutureBuilder(
              future: webtoon,
              builder: (context, AsyncSnapshot<WebtoonDetailModel> snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '${snapshot.data!.about}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${snapshot.data!.genre} / ${snapshot.data!.age}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
          ),
        ],
      ),
    );
  }
}
