import 'package:firestoreproject/viewmodel/news_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';

class Homes extends StatelessWidget {
  const Homes({super.key});

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
      ),
      drawer: Drawer(
          backgroundColor: Theme.of(context).colorScheme.surface,
          child: Column(children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: HexColor("303050"),
                border: const Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 0.0,
                  ),
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 20),
              child: ListTile(
                title: const Text(
                  "H O M E",
                  style: TextStyle(fontFamily: "Sora"),
                ),
                leading: const Icon(Icons.home),
                onTap: () {
                  //pop the drawer
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ListTile(
                title: const Text(
                  "S E T T I N G S",
                  style: TextStyle(fontFamily: "Sora"),
                ),
                leading: const Icon(Icons.settings),
                onTap: () {
                  //pop the drawer
                  Navigator.pop(context);
                },
              ),
            ),
            const Spacer(),
            Container(
              color: HexColor("303050"),
              child: ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Sora",
                  ),
                ),
                onTap: () {
                  // Handle logout action
                  Navigator.pop(context); // Close the drawer
                },
              ),
            )
          ])),
      body: Consumer<NewsViewModel>(
        builder: (context, newsViewModel, child) {
          if (newsViewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (newsViewModel.news == null) {
            return const Center(child: Text("Failed to load news"));
          }

          return ListView.builder(
            itemCount: newsViewModel.news!.articles.length,
            itemBuilder: (context, index) {
              final article = newsViewModel.news!.articles[index];
              return GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              article.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Published at: ${article.publishedAt}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              article.description ?? 'No description available',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          article.urlToImage ??
                              'https://cdn.iconscout.com/icon/free/png-256/free-no-image-1771002-1505134.png',
                          fit: BoxFit.fitHeight,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.network(
                              'https://cdn.iconscout.com/icon/free/png-256/free-no-image-1771002-1505134.png',
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            article.title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Source: ${article.source.name}",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
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
