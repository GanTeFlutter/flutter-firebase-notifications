import 'package:flutter/material.dart';
import 'package:flutter_base_start/product/service/service_locator.dart';

class Deneme extends StatefulWidget {
  const Deneme({super.key});

  @override
  State<Deneme> createState() => _DenemeState();
}

class _DenemeState extends State<Deneme> {
  String? messageData;
  void getMessageData() {
    setState(() {
      messageData = locator.sharedprefs.getString('messageData');
    });
  }

  @override
  void initState() {
    super.initState();
    getMessageData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Deneme')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Text(messageData ?? 'No message data found.'),
          ],
        ),
      ),
    );
  }
}
