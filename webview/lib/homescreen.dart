import 'package:flutter/material.dart';
import 'package:webview/webview.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final TextEditingController _searchController = TextEditingController();

  void _search() {
    String query = _searchController.text.trim();

    bool isUrl = Uri.parse(query).isAbsolute;
    if (isUrl) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyWebView(url: query),
        ),
      );
    } else {
      String searchUrl = 'https://www.google.com/search?q=$query';
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyWebView(url: searchUrl),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "WebView Asim's Internet Browser",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/browser.png"),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  suffixIcon: InkWell(
                    onTap: _search,
                    child: const Icon(Icons.search),
                  ),
                ),
                onSubmitted: (value) => _search(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
