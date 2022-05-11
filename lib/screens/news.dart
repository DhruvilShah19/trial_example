import 'package:flutter/material.dart';
import 'package:trial_example/Modals/fetchNews.dart';
import 'package:trial_example/screens/article.dart';

// ignore: must_be_immutable
class NewsPage extends StatefulWidget {
  String value;
  NewsPage({this.value});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  // ignore: deprecated_member_use
  List<ArticleModel> articles = new List<ArticleModel>();

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    if (mounted) {
      setState(() {
        // _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            ),
            ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return BlogCategory(
                    title: articles[index].title,
                    description: articles[index].description,
                    imageUrl: articles[index].urlToImage,
                    url: articles[index].url,
                  );
                }),
          ]),
        ),
      ),
    );
  }
}

class BlogCategory extends StatelessWidget {
  final title;
  final description;
  final imageUrl;
  final url;

  const BlogCategory({this.title, this.description, this.imageUrl, this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ArticleView(
                    blogurl: url,
                  )),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(imageUrl)),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0),
                ),
              ),
              Text(
                description,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
