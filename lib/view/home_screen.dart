import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:head_line_hub/model/news_channel_headlines_model.dart';
import 'package:head_line_hub/view/detailedView.dart';
import 'package:head_line_hub/viewModel/news_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  final format = DateFormat('MMMM dd, yyyy');

  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    final newsApi = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            'assets/images/category_icon.png',
            height: height * 0.028,
          ),
        ),
        title: Text(
          'Head Lines Hub',
          style: GoogleFonts.abel(
              textStyle: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .75,
            width: width,
            child: FutureBuilder<NewsChannelHeadLinesModel>(
              future: newsApi.fetchNewsFromApi(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitFadingCircle(
                      color: Colors.grey,
                    ),
                  );
                }
                return ListView.builder(

                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.articles!.length,
                  itemBuilder: (context, index) {
                    final news =  snapshot.data!.articles![index];
                    DateTime date = DateTime.parse(
                        snapshot.data!.articles![index].publishedAt.toString());
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailedNews(newsDetails: news.content.toString(),tittle: news.title.toString(), imageUrl: snapshot
                            .data!.articles![index].urlToImage
                            .toString(),),),);
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: height * 0.9,
                            width: width ,
                            padding:
                                EdgeInsets.symmetric(horizontal: height * 0.02),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl: snapshot
                                    .data!.articles![index].urlToImage
                                    .toString(),
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    const SpinKitPulse(
                                  color: Colors.grey,
                                ),
                                placeholder: (context, url) => const SpinKitPulse(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            child: Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                height: height * .16,
                                alignment: Alignment.bottomCenter,
                                padding: const EdgeInsets.all(15),
                                child: Column(

                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: width * 0.7,
                                      child: Text(
                                        snapshot.data!.articles![index].title
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: width * 0.7,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data!.articles![index]
                                                .source!.name
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Text(
                                            format.format(date),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
