import 'package:firestoreproject/model/news_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsViewModel extends ChangeNotifier {
  News? news;
  bool isLoading = true;

  Future<void> fetchNews() async {
    final response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=in&apiKey=f6e55577b1d84fc9bbe09340a19669f9'));

    if (response.statusCode == 200) {
      news = newsFromJson(response.body);
    } else {
      throw Exception('Failed to load news');
    }

    isLoading = false;
    notifyListeners();
  }
}
