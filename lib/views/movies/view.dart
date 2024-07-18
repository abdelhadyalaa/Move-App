import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'model.dart';

part 'item.dart';

class MoviesView extends StatefulWidget {
  const MoviesView({Key? key}) : super(key: key);

  @override
  State<MoviesView> createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView> {
  List<MovieModel> list = [];

  bool isLoading = false;
  bool isFailed = false;

  Future<void> getData() async {
    isLoading = true;
    setState(() {});
    try {
      var response = await Dio().get(
          'https://api.themoviedb.org/3/discover/movie?api_key=2001486a0f63e9e4ef9c4da157ef37cd');
      var model = MoviesData.fromJson(response.data);
      list.addAll(model.list);
      // print(response.data["results"]);
      // var responseList= response.data["results"] as List;
      // for(int i =0; i <responseList.length;i++){
      //   var model= MovieModel(
      //       image:
      //       "https://image.tmdb.org/t/p/original${responseList[i]["backdrop_path"]}",
      //       title: responseList[i]["original_title"],
      //       subTitle: responseList[i]["overview"],
      //       rate: double.parse(responseList[i]["vote_average"].toString()));
      //   list.add(model);
      // }

      // var item=( response.data["results"] as List)[0];
      // // print(item["original_title"]);
      // var model= MovieModel(
      //     image:
      //     "https://media0029.elcinema.com/uploads/_640x_1b6e345756ffed68fd91ae9fe69526fc187e291734aec1baacfd436ca287c239.jpg",
      //     title: item["original_title"],
      //     subTitle: "subTitle 1",
      //     rate: 3.5);
    } on DioException catch (ex) {
      isFailed = true;
    }

    isLoading = false;
    // list.add(model);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : isFailed
              ? Center(
                  child: Text("Failed"),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) => _Item(model: list[index]),
                  separatorBuilder: (context, index) => const Divider(
                        color: Colors.red,
                      ),
                  itemCount: list.length),
    );
  }
}
