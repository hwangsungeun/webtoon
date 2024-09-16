import 'package:flutter/material.dart';

import '../services/api_service.dart';

class DetailScreen extends StatelessWidget {
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

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
        title: Text(title),
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
                tag: id,
                child: Container(
                  width: 200,
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
                      thumb,
                      fit: BoxFit.cover,
                      headers: const {
                        'User-Agent' : ApiService.userAgent
                      },
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
