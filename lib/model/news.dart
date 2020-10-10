
import 'package:http/http.dart';
import 'package:newsagain/model/articlemodel.dart';
import 'dart:convert';


class News{

  List<ArticleModel> news =[];

  getNews() async {

    String url = 'http://newsapi.org/v2/top-headlines?country=au&category=business&apiKey=1bbf10f8fdf14c29bb263600cf1f3a35';

    Response response = await get(url);
    var decodedData = json.decode(response.body);

  if (decodedData['status'] == "ok"){
      decodedData["articles"].forEach( (element) {
        if( element["urlToImage"] != null && element["description"] != null )
        {
         ArticleModel articleModel = ArticleModel(
              title: element['title'],
              author: element["author"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              publishedAt: element["publishedAt"],
              content: element["content"],
          );
          news.add(articleModel);
        }
      });

    }
  }
}


class CategoryNewsClass{

  List<ArticleModel> news =[];

  getNews(String category) async { 

    String url = 'http://newsapi.org/v2/top-headlines?country=au&category=$category&apiKey=1bbf10f8fdf14c29bb263600cf1f3a35';

    Response response = await get(url);
    var decodedData = json.decode(response.body);

  if (decodedData['status'] == "ok"){
      decodedData["articles"].forEach( (element) {
        if( element["urlToImage"] != null && element["description"] != null )
        {
         ArticleModel articleModel = ArticleModel(
              title: element['title'],
              author: element["author"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              publishedAt: element["publishedAt"],
              content: element["content"],
          );
          news.add(articleModel);
        }
      });

    }
  }
}