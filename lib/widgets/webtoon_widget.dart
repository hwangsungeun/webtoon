import 'package:flutter/material.dart';
import 'package:webtoon/screens/detail_screen.dart';
import 'package:webtoon/services/api_service.dart';

class WebtoonWidget extends StatelessWidget {

  final String title, thumb, id;

  WebtoonWidget({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    /*
    * GestureDetector 는 대부분에 동작을 감지하도록 해줌
    * 클릭 등
    * */
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                DetailScreen(
                    title: title,
                    thumb: thumb,
                    id: id
                ),
              fullscreenDialog: true,
            ),
        );
      },
      child: Column(
        children: [
          const Flexible(
            flex: 1,
              child: SizedBox(
                height: 200,
              ),
          ),
          Flexible(
            flex: 5,
            child: Container(
              margin: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 4.0,
                    ),
                  ]
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Hero(
                      tag: id,
                      child: Container(
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
                            height: (MediaQuery.of(context).size.height / 2),
                            width: double.infinity,
                            thumb,
                            fit: BoxFit.cover,
                            headers: const {
                              'User-Agent' : ApiService.userAgent
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                        title
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5, (index) => const Icon(
                        Icons.star,
                        size: 20,
                        color: Colors.orange,
                      ),)
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}