import 'package:flutter/material.dart';
import 'package:flutter_base_start/product/service/service_locator.dart';
import 'package:flutter_base_start/product/service/services/firebase_fcm.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    getBackgroundMessage();
  }

  String? lastMessageData;
  String? lastMessageTitle;
  String? lastMessageBody;

  void getBackgroundMessage() {
    lastMessageData = locator.sharedprefs.getString(PrefKeys.lastMessageData);
    lastMessageTitle = locator.sharedprefs.getString(PrefKeys.lastMessageTitle);
    lastMessageBody = locator.sharedprefs.getString(PrefKeys.lastMessageBody);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(lastMessageData ?? 'Arka planda mesaj yok'),
          Text('Başlık: $lastMessageTitle'),
          Text('Gövde: $lastMessageBody'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
