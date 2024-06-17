import 'package:adv_exam/screen/home/model/home_model.dart';
import 'package:adv_exam/screen/home/provider/home_provider.dart';
import 'package:adv_exam/utils/shared_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().getJokesApi();
    pullToRefreshController = PullToRefreshController(
      onRefresh: () {
        inAppWebViewController!.reload();
        pullToRefreshController!.endRefreshing();
      },
    );
  }

  HomeProvider? providerR;
  HomeProvider? providerW;
  GlobalKey webKey = GlobalKey();
  InAppWebViewController? inAppWebViewController;
  PullToRefreshController? pullToRefreshController;

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
        height: MediaQuery.sizeOf(context).height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff66cddd),
          Color(0xff28cae2),
          Color(0xff056675)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: FutureBuilder(
          future: providerW!.model,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              JokesModel? model = snapshot.data;
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, 'like', arguments: model);
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage("${model!.url}"),
                    ),
                    title: Text("${model.value}"),
                    subtitle: Text("Create: ${model.created_at}"),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {
                            SharedHelper helper = SharedHelper();
                            helper.setSharedData("${model.value}");
                            providerR!.addLikeJokes(model);
                          },
                          icon: const Icon(Icons.favorite_border_outlined)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.refresh_outlined)),
                    ],
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xff66cddd),
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Center(
                  child: Text(
                "📘",
                style: TextStyle(fontSize: 100),
              )),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.home_outlined,
                      size: 24,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const Text(
                    "Home",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'like');
                    },
                    icon: const Icon(
                      Icons.favorite_border_outlined,
                      size: 24,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const Text(
                    "Favourite",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.share_outlined,
                      size: 24,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const Text(
                    "Share",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
