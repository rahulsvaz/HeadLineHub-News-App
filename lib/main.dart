import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:head_line_hub/view/splash_screen.dart';
import 'package:head_line_hub/viewModel/news_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>NewsProvider())
      ],
      child: MyApp()));
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title:'Head Lines Hub' ,
      theme: ThemeData(
        useMaterial3: true

      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
