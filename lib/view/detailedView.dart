import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailedNews extends StatefulWidget {
  final String imageUrl;

  final String tittle;
  final String newsDetails;

  const DetailedNews(
      {super.key,
      required this.imageUrl,
      required this.tittle,
      required this.newsDetails});

  @override
  State<DetailedNews> createState() => _DetailedNewsState();
}

class _DetailedNewsState extends State<DetailedNews> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(8),
            height: 400,
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              errorWidget: (context, url, error) => const SpinKitPulse(
                color: Colors.grey,
              ),
              placeholder: (context, url) => const SpinKitPulse(
                color: Colors.grey,
              ),
            ),
          ),
          Text(widget.tittle,
              style:
                  GoogleFonts.abel(fontSize: 24, fontWeight: FontWeight.bold),),
          SizedBox(height: 500,
            width:width,
            child: SingleChildScrollView(
              child: Text(
                widget.newsDetails,
               
              ),
            ),
          )
        ],
      ),
    );
  }
}
