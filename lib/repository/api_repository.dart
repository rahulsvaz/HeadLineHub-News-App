import 'dart:convert';
import 'package:head_line_hub/model/news_channel_headlines_model.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  String url =
      'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=d27014a8d15a4550afb8859aad322824';

  Future<NewsChannelHeadLinesModel> fetchNewsApi() async {
    final response = await http.get(Uri.parse(url));
    var body = jsonDecode(response.body);
    if (response.statusCode == 200) {


      print(body);

      return NewsChannelHeadLinesModel.fromJson(body);
    }
    return body;
  }
}
