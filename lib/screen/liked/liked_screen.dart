import 'package:adv_exam/screen/home/model/home_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/provider/home_provider.dart';

class LikedScreen extends StatefulWidget {
  const LikedScreen({super.key});

  @override
  State<LikedScreen> createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {
  HomeProvider? providerR;
  HomeProvider? providerW;

  @override
  Widget build(BuildContext context) {
    providerR = context.read<HomeProvider>();
    providerW = context.watch<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jokes"),
        centerTitle: true,
        backgroundColor: const Color(0xff66cddd),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff66cddd),
          Color(0xff28cae2),
          Color(0xff056675)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: ListView.builder(
          itemCount: providerW!.likeList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  title: Text("${providerR!.likeList[index].value}"),
                  trailing: IconButton(
                    onPressed: () {
                      providerW!.removeJokes(index);
                    },
                    icon: const Icon(Icons.delete_outline),
                  ),
                ),
                const Divider(
                  color: Colors.black,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
