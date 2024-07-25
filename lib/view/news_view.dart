import 'package:firestoreproject/viewmodel/news_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';

class Homes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("303050"),
        title: const Text(
          "News Headlines",
          style: TextStyle(fontFamily: "Sora", color: Colors.white),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<NewsViewModel>(
        builder: (context, newsViewModel, child) {
          if (newsViewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (newsViewModel.news == null) {
            return Center(child: Text("Failed to load news"));
          }

          return ListView.builder(
            itemCount: newsViewModel.news!.articles.length,
            itemBuilder: (context, index) {
              final article = newsViewModel.news!.articles[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      article.urlToImage != null
                          ? Image.network(article.urlToImage!)
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          article.title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Source: ${article.source.name}",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
