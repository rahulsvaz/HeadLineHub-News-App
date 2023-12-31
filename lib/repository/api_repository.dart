import 'dart:convert';
import 'dart:developer';
import 'package:head_line_hub/model/news_channel_headlines_model.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  // indian news
  String url2 = "https://newsapi.org/v2/top-headlines?country=in&apiKey=d27014a8d15a4550afb8859aad322824";
  String url =
      'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=d27014a8d15a4550afb8859aad322824';

  Future<NewsChannelHeadLinesModel> fetchNewsApi() async {
    final response = await http.get(Uri.parse(url2));
    var body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return NewsChannelHeadLinesModel.fromJson(body);
    }
    return body;
  }
}
