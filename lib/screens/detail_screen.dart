import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
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
  late WebtoonDetailModel webtoon = WebtoonDetailModel();
  late List<WebtoonEpisodeModel> episode = [];
  late SharedPreferences prefs;
  bool isLiked = false;

  getLatestEpisodesById(String id) async {
    webtoon = await ApiService.getToonById(widget.id);
    episode = await ApiService.getLatestEpisodesById(id);

    setState(() {});
  }

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      if (likedToons.contains(widget.id) == true) {
        setState(() {
          isLiked = true;
        });
      }
    } else {
      await prefs.setStringList('likedToons', []);
    }
  }

  onHeartTap() async {
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      if (isLiked) {
        likedToons.remove(widget.id);
      } else {
        likedToons.add(widget.id);
      }
      
      await prefs.setStringList('likedToons', likedToons);

      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getLatestEpisodesById(widget.id);
    // episode = ApiService.getLatestEpisodesById(widget.id);
    initPrefs();
  }

  onButtonTap(String webtoonId, WebtoonEpisodeModel episode) async {
    await launchUrlString('https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}');
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
        actions: [
          IconButton(onPressed: () {
            onHeartTap();
          }, icon: Icon(
            isLiked ? Icons.favorite : Icons.favorite_outline_outlined,
            color: Colors.white,
          ),),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
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
                Builder(builder: (context) {
                  return webtoon.title != null ?
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Builder(builder: (context) {
                          return Text(
                            '${webtoon.about}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        },),

                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${webtoon.genre} / ${webtoon.age}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                },),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          SliverList.builder(
            itemCount: episode.length,
            itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(
                  45,
                  0,
                  45,
                  10
              ),
              child: GestureDetector(
                onTap: () {
                  onButtonTap(widget.id, episode[index]);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green.shade500,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            maxLines: 1,
                            '${episode[index].title}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
            ),
          ),
        ],
      ),
    );
  }
}
