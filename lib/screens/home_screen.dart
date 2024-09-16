import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webtoon/model/webtoon_model.dart';
import 'package:webtoon/services/api_service.dart';
import 'package:webtoon/widgets/webtoon_widget.dart';

/*class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<WebtoonModel> webtoons = [];
  bool isLoading = true;

  void waitForWebToons() async {
    webtoons = await ApiService.getToDaysToons();
    isLoading = false;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    waitForWebToons();
  }*/
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  final Future<List<WebtoonModel>> webtoons = ApiService.getToDaysToons();

  int currenIndex = 0;

  double pageValue = 0.0;

  late int pageCount;

  late PageController pageController;

  late Offset offset;

  late double deviceWidth;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 5,
          shadowColor: Colors.black,
          surfaceTintColor: Colors.black,
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text('오늘의 웹툰'),
          titleTextStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 25,
          ),
        ),
        /*
        * StatefulWidget 말고
        * FutureBuilder 로 데이터를 갱신 할 수 있다
        * */
        body: FutureBuilder(
            future: webtoons,
            builder: (context, AsyncSnapshot<List<WebtoonModel>> snapshot) {
            //   snapshot은 future에 상태를 알 수 있음
              if(snapshot.hasData) {
                /*
                * ListView 모두다 로드, ListView.builder 화면에 보일때만 로드
                * ListView 는 한꺼번에 로드
                * ListView.builder 화면에 보일때만 로드
                * ListView.separated 는 separatorBuilder 구분자를 넣을 수 있음
                * */
                return Stack(
                  children: [
                    Image.network(
                      // opacity: AlwaysStoppedAnimation(1),
                      height: double.infinity,
                      snapshot.data![currenIndex].thumb,
                      fit: BoxFit.cover,
                      headers: const {
                        'User-Agent' : ApiService.userAgent
                      },
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.white,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.3, 0.8]),
                      ),
                    ),
                    PageView.builder(
                      onPageChanged: (index) {
                        currenIndex = index;
                      },
                      physics: const ClampingScrollPhysics(),
                      controller: pageController = PageController(
                        viewportFraction: 0.8,
                        initialPage: currenIndex,
                      )..addListener(() {
                        setState(() {
                          pageValue = pageController.page!;
                        });
                      },),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        // floor -> toInt 와 같다
                        if (index == pageValue.floor() +1 || index == pageValue.floor() +2) {
                          offset = Offset(0.0, 100 * (index - pageValue));
                        } else if (index == pageValue.floor() || index == pageValue.floor() -1) {
                          offset = Offset(0.0, 100 * (pageValue - index));
                        } else {
                          offset = const Offset(0, 0);
                        }

                        return Transform.translate(
                          offset: offset,
                          child: WebtoonWidget(
                            title: snapshot.data![index].title,
                            thumb: snapshot.data![index].thumb,
                            id: snapshot.data![index].id,
                          ),
                        );
                      },
                    ),
                    /*
                    * Stack에선 위젯들의 위치를 사용자가 직접 정해줘야하는데,
                    * 이때 위치를 특정하기 위해 사용하는 위젯이 Positioned Class입니다.
                    * */
                    /*Positioned(
                      bottom: 32,
                      left: 0,
                      right: 0,
                      child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 62.0),
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "BUY WebToon",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),),*/
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
        ),
      ),
    );
  }
}