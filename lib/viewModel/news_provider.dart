import 'package:flutter/material.dart';
import 'package:head_line_hub/model/news_channel_headlines_model.dart';
import 'package:head_line_hub/repository/api_repository.dart';

class NewsProvider with ChangeNotifier {
  final _repo = NewsRepository();

  Future<NewsChannelHeadLinesModel> fetchNewsFromApi() async {
    final response = await _repo.fetchNewsApi();
    return response;
  }
}
