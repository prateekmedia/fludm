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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
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
                          (item.status.isDownloading
                                  ? item.actual.getFileSize + '/'
                                  : '') +
                              "${item.total.getFileSize}   3 MB/s    40 min",
                          style: context.textTheme.bodyText2!
                              .copyWith(fontSize: 12),
                        ),
                      ],
                    )),
                    if (item.status.isDownloading) ...[
                      const Icon(Ionicons.pause_outline, size: 22),
                      const SizedBox(width: 12),
                      const Icon(Ionicons.stop_outline, size: 22),
                    ] else ...[
                      const Icon(Ionicons.folder_outline, size: 22),
                      const SizedBox(width: 12),
                      const Icon(Icons.restart_alt_outlined, size: 22),
                      const SizedBox(width: 12),
                      const Icon(Ionicons.trash_bin_outline, size: 22),
                    ],
                  ],
                ),
                if (item.status.isDownloading)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: LinearProgressIndicator(
                      value: 4.7 / 9.2,
                      backgroundColor:
                          context.isDark ? Colors.grey[700] : Colors.grey[50],
                      color: item.type.getColor,
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
