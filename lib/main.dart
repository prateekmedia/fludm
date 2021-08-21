import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:fludm/utils/utils.dart';
import 'package:fludm/widgets/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FluDM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Poppins',
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        primaryColor: Colors.purple[200],
        fontFamily: 'Poppins',
      ),
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<DownloadItem> downloadItems = [
      DownloadItem(
        name: "Cold - Copyright free song.mp3",
        type: FileType.audio,
        actual: 4200000,
        total: 9000000,
        path: "/home/user/",
        datetime: DateTime.now().subtract(const Duration(seconds: 10)),
        status: DownloadStatus.downloading,
      ),
      DownloadItem(
        name: "Cold - Copyright free music video.mp4",
        type: FileType.video,
        actual: 38000000,
        total: 50000000,
        path: "/home/user/",
        datetime:
            DateTime.now().subtract(const Duration(seconds: 10, days: 10)),
        status: DownloadStatus.paused,
      ),
      DownloadItem(
        name: "Cold - Copyright free music video.zip",
        type: FileType.compressed,
        actual: 8000000,
        total: 40000000,
        path: "/home/user/",
        datetime: DateTime.now().subtract(const Duration(seconds: 10, days: 1)),
        status: DownloadStatus.downloading,
      ),
      DownloadItem(
        name: "Cold - Copyright free album art.png",
        type: FileType.image,
        actual: 300000,
        total: 300000,
        path: "/home/user/",
        datetime: DateTime.now().subtract(const Duration(seconds: 10, days: 1)),
        status: DownloadStatus.completed,
      ),
      DownloadItem(
        name: "Cold - Copyright free app.exe",
        type: FileType.program,
        actual: 50000000,
        total: 300000000,
        path: "/home/user/",
        datetime: DateTime.now().subtract(const Duration(seconds: 10, days: 4)),
        status: DownloadStatus.cancelled,
      ),
      DownloadItem(
        name: "Cold - Copyright free.crx",
        type: FileType.other,
        actual: 600000000,
        total: 600000000,
        path: "/home/user/",
        datetime: DateTime.now().subtract(const Duration(seconds: 10, days: 6)),
        status: DownloadStatus.completed,
      ),
    ];

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (context.width > 700)
            Sidebar(
              currentIndex: currentIndex,
              onTap: (index) {
                currentIndex = index;
                setState(() {});
              },
              start: Container(
                margin: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  "FluDM",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold, letterSpacing: 1),
                ),
              ),
              items: [
                SidebarItem(
                  icon: const Icon(Ionicons.arrow_down_circle_outline),
                  label: 'All Downloads',
                ),
                SidebarItem(
                  icon: const Icon(Ionicons.download_outline),
                  label: 'Downloading',
                ),
                SidebarItem(
                  icon: const Icon(Ionicons.checkmark_circle_outline),
                  label: 'Completed',
                ),
              ],
            ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              children: [
                if (currentIndex != 2) ...[
                  Text(
                    "Downloading",
                    style: context.textTheme.bodyText1!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  ...downloadItems
                      .where((element) => element.isDownloadingOrPaused)
                      .map(
                        (item) => DownloadItemWidget(item: item),
                      ),
                  const SizedBox(height: 15),
                ],
                if (currentIndex != 1) ...[
                  Text(
                    "Completed",
                    style: context.textTheme.bodyText1!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  ...downloadItems
                      .where((element) => element.isCancelledOrCompleted)
                      .map(
                        (item) => DownloadItemWidget(item: item),
                      ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
