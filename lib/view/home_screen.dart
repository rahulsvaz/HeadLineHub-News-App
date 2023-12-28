import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:head_line_hub/model/news_channel_headlines_model.dart';
import 'package:head_line_hub/viewModel/news_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
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
            height: height * .55,
            width: width,
            child: FutureBuilder<NewsChannelHeadLinesModel>(
              future: newsApi.fetchNewsFromApi(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const  Center(
                    child: SpinKitFadingCircle(
                      color: Colors.grey,
                    ),
                  );
                }
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      return Stack(alignment: Alignment.center, children: [
                        Container(
                          height: height*0.6,
                          width: width*.9,
                          padding: EdgeInsets.symmetric(horizontal:height*0.02  ),

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              imageUrl: snapshot.data!.articles![index].urlToImage
                                  .toString(),
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => const SpinKitPulse(
                                color: Colors.grey,
                              ),
                              placeholder: (context, url) => const SpinKitPulse(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ]);
                    });
              },
            ),
          )
        ],
      ),
    );
  }
}
