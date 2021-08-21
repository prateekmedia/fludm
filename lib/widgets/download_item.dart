import 'package:fludm/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class DownloadItem {
  final String name;
  final int actual;
  final int total;
  final FileType type;
  final DownloadStatus status;
  final String path;

  DownloadItem({
    required this.name,
    required this.actual,
    required this.total,
    required this.type,
    required this.status,
    required this.path,
  });
}

extension DownloadStatExtension on DownloadItem {
  bool get isDownloading => status.index == 0 ? true : false;
  bool get isPaused => status.index == 1 ? true : false;
  bool get isCancelled => status.index == 2 ? true : false;
  bool get isCompleted => status.index == 3 ? true : false;

  bool get isDownloadingOrPaused => isDownloading || isPaused ? true : false;
  bool get isCancelledOrCompleted => isCancelled || isCompleted ? true : false;
}

class DownloadItemWidget extends StatelessWidget {
  final DownloadItem item;

  const DownloadItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.isDark ? Colors.grey[900] : Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: item.type.getColor,
            ),
            child: item.type.getIcon,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          (item.isDownloadingOrPaused
                                  ? item.actual.getFileSize + ' / '
                                  : '') +
                              "${item.total.getFileSize}   ·   3 MB/s   ·   " +
                              (item.isPaused
                                  ? "Paused"
                                  : item.isCancelled
                                      ? "Cancelled"
                                      : "40 min"),
                          style: context.textTheme.bodyText2!
                              .copyWith(fontSize: 12),
                        ),
                      ],
                    )),
                    if (item.isCompleted) ...[
                      const Icon(Ionicons.folder_outline, size: 20),
                      const SizedBox(width: 15),
                      const Icon(Ionicons.open_outline, size: 20),
                      const SizedBox(width: 15),
                    ] else if (item.isCancelled) ...[
                      const Icon(Icons.restart_alt_outlined, size: 20),
                      const SizedBox(width: 15),
                    ],
                    if (item.isDownloadingOrPaused) ...[
                      Icon(
                        item.isPaused
                            ? Ionicons.play_outline
                            : Ionicons.pause_outline,
                        size: 20,
                      ),
                      const SizedBox(width: 15),
                      const Icon(Ionicons.stop_outline, size: 20),
                    ] else ...[
                      const Icon(Ionicons.trash_bin_outline, size: 20),
                    ],
                  ],
                ),
                if (item.isDownloadingOrPaused)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: LinearProgressIndicator(
                      value: item.actual / item.total,
                      backgroundColor:
                          context.isDark ? Colors.grey[700] : Colors.grey[50],
                      color: item.status == DownloadStatus.paused
                          ? Colors.grey
                          : context.primaryColor,
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
