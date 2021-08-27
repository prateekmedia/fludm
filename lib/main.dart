import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'utils/utils.dart';
import 'widgets/widgets.dart';

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

  double downloadHeader = 0;
  double completedHeader = 0;
  double settingsHeader = 0;

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
              endItem: SidebarItem(
                icon: const Icon(Ionicons.settings_outline),
                label: 'Settings',
              ),
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
              children: [
                if (currentIndex <= 1) ...[
                  StickyHeader(
                    callback: (offset) => WidgetsBinding.instance!
                        .addPostFrameCallback((_) => setState(() {
                              downloadHeader = offset >= 0 ? 0 : offset;
                            })),
                    header: AnimatedContainer(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10 - 5 * downloadHeader.abs()),
                      color: (context.isDark
                              ? Colors.grey[900]!
                              : Colors.grey[200]!)
                          .withOpacity(downloadHeader.abs()),
                      duration: const Duration(milliseconds: 250),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Downloading",
                            style: context.textTheme.headline6!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          Row(
                            children: const [
                              HeaderButton(
                                icon: Ionicons.play_outline,
                                tooltip: 'Resume selected',
                              ),
                              HeaderButton(
                                icon: Ionicons.pause_outline,
                                tooltip: 'Pause selected',
                              ),
                              HeaderButton(
                                icon: Ionicons.close_outline,
                                tooltip: 'Cancel selected',
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    content: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                          children: downloadItems
                              .where((element) => element.isDownloadingOrPaused)
                              .map(
                                (item) => DownloadItemWidget(item: item),
                              )
                              .toList()),
                    ),
                  ),
                  // const SizedBox(height: 6),
                  const SizedBox(height: 15),
                ],
                if (currentIndex <= 2 && currentIndex != 1) ...[
                  StickyHeader(
                    callback: (offset) => WidgetsBinding.instance!
                        .addPostFrameCallback((_) => setState(() {
                              completedHeader = offset >= 0 ? 0 : offset;
                            })),
                    header: AnimatedContainer(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10 - 5 * completedHeader.abs()),
                      color: (context.isDark
                              ? Colors.grey[900]!
                              : Colors.grey[200]!)
                          .withOpacity(completedHeader.abs()),
                      duration: const Duration(milliseconds: 250),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Completed",
                            style: context.textTheme.headline6!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          Row(
                            children: const [
                              HeaderButton(
                                icon: Icons.restart_alt_outlined,
                                tooltip: 'Restart selected',
                              ),
                              HeaderButton(
                                icon: Ionicons.trash_bin_outline,
                                tooltip: 'Delete selected',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    content: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: downloadItems
                            .where((element) => element.isCancelledOrCompleted)
                            .map(
                              (item) => DownloadItemWidget(item: item),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ],
                if (currentIndex == 3) ...[
                  StickyHeader(
                    callback: (offset) => WidgetsBinding.instance!
                        .addPostFrameCallback((_) => setState(() {
                              settingsHeader = offset >= 0 ? 0 : offset;
                            })),
                    header: AnimatedContainer(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10 - 5 * settingsHeader.abs()),
                      color: (context.isDark
                              ? Colors.grey[900]!
                              : Colors.grey[200]!)
                          .withOpacity(settingsHeader.abs()),
                      duration: const Duration(milliseconds: 250),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Settings",
                            style: context.textTheme.headline6!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          Row(
                            children: const [
                              HeaderButton(
                                icon: Icons.restart_alt_outlined,
                                tooltip: 'Restore defaults',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    content: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text("TBD"),
                    ),
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

class HeaderButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final String? tooltip;

  const HeaderButton({
    Key? key,
    required this.icon,
    this.onTap,
    this.tooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color =
        onTap != null ? context.textTheme.bodyText1!.color! : Colors.grey;
    var child = Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Icon(icon, size: 15, color: color),
    );
    return tooltip != null
        ? Tooltip(
            message: tooltip!,
            child: child,
          )
        : child;
  }
}
