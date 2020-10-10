
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsagain/model/categorydata.dart';
import 'package:newsagain/model/news.dart';
import 'package:newsagain/screen/article_view.dart';
import 'package:newsagain/screen/category_news.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  CategoryData categoryData=CategoryData();
   
   //List<ArticleModel> news = List<ArticleModel>();
  News fetchnews = News();
  var newsone;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getNews();

  }

  getNews() async{
   await fetchnews.getNews();
   setState(() {
  newsone = fetchnews.news;
  isLoading = false;
   });
  }
  
  @override
  Widget build(BuildContext context) {
    return 
          Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text('Flutter',style: TextStyle(
              //   color: Colors.black,
              //   fontWeight: FontWeight.bold,
              // ),),
              Text('News',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),),
            ],
          ),
        ),
        body: isLoading == true ? Center(
          child: Container(
            child : CircularProgressIndicator(
              
            ),
          ),
        ) :SingleChildScrollView(
                  child: Container(
             padding: EdgeInsets.symmetric(horizontal : 16),
                child : Column(
                  children: [
          //categories
          Container(
            height: 80,
           
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryData.data.length,
              shrinkWrap: true,
              itemBuilder: (context, index){
                  return CategoryTile(
          imageUrl: categoryData.data[index].imageUrl,
          title: categoryData.data[index].title,
                  );
                 },
                 ),
          ),
          
          //blogs
                  Container(
          //height: 500.0,
          padding: EdgeInsets.only(top : 16),
          child: ListView.builder(
              
                itemCount: fetchnews.news.length,
             shrinkWrap: true,
             physics: ClampingScrollPhysics(),
              itemBuilder: (context , index) {
                return BlogTile(
                  imageUrl: fetchnews.news[index].urlToImage,
                  title: fetchnews.news[index].title,
                  description: fetchnews.news[index].description,
                  url: fetchnews.news[index].url,
                );
            }),
          ),
                  ],
                ),
              ),
        ),
    );
  }
}

class CategoryTile extends StatelessWidget {

  final String imageUrl;
  final String title;
  CategoryTile({this.imageUrl, this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return CategoryNews(
            category: title.toLowerCase(),
          );
        
        },),);
      },
          child: Container(
        margin: EdgeInsets.only(right : 16.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl : imageUrl,
                width: 120,
                height: 80,
                fit: BoxFit.cover,
                ),
                ),
            Container(
               height: 80,
              width: 120,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(6)
              ),
              child: Text(
                title,
              style:TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),),
            ),
          ],
        ),
        
      ),
    );
  }
}

class BlogTile extends StatelessWidget {

  final String imageUrl,title,description,url;

  BlogTile({this.imageUrl, this.title, this.description,this.url});
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ArticleView(
              blogUrl: url,
            );
          }));
      },
          child: Container(
        margin: EdgeInsets.only(bottom: 16,),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl),
              ),
              SizedBox(
                height:8,
              ),
              Text(
                title,
              style:TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              color: Colors.black87,
              ),
              ),
              SizedBox(
                height:8,
              ),
              Text(
                description,
              style: TextStyle(
                color: Colors.black54,
                ),
                ),
                Divider(
                  thickness: 1.5,
                ), 
          ],
        ),
      ),
    );
  }
}