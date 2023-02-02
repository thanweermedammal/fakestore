import 'package:fake_store/helper/item_list.dart';
import 'package:fake_store/view/home.dart';
import 'package:fake_store/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ItemList(),
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          darkTheme: ThemeData.dark(),
          home: LoginScreen()),
    );
  }
}
