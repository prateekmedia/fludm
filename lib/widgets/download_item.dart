import 'package:fludm/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:intl/intl.dart';

class DownloadItem {
  final String name;
  final int actual;
  final int total;
  final Function(bool active, DownloadItem item)? onItemSelected;
  final FileType type;
  final DownloadStatus status;
  final String path;
  final DateTime datetime;

  DownloadItem({
    required this.name,
    required this.actual,
    required this.total,
    required this.type,
    required this.onItemSelected,
    required this.status,
    required this.path,
    required this.datetime,
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

class DownloadItemWidget extends StatefulWidget {
  final DownloadItem item;

  const DownloadItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<DownloadItemWidget> createState() => _DownloadItemWidgetState();
}

class _DownloadItemWidgetState extends State<DownloadItemWidget> {
  bool isHovered = false;
  bool isActive = false;
  set setHovered(bool hover) => setState(() => isHovered = hover);
  set setActive(bool active) {
    setState(() => isActive = active);
    widget.item.onItemSelected?.call(active, widget.item);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (_) => setHovered = true,
      onExit: (_) => setHovered = false,
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: (context.isDark ? Colors.grey[900]! : Colors.grey[200]!).withOpacity(isActive
              ? 1
              : isHovered
                  ? 0.6
                  : 0),
          borderRadius: BorderRadius.circular(15),
        ),
        curve: Curves.fastOutSlowIn,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 4),
        duration: const Duration(milliseconds: 150),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => setActive = !isActive,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: widget.item.type.getColor.darken(isActive ? 40 : 1),
                ),
                child: widget.item.type.getIcon,
              ),
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
                            widget.item.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            (widget.item.isDownloadingOrPaused ? widget.item.actual.getFileSize + ' / ' : '') +
                                "${widget.item.total.getFileSize}   ·   ${widget.item.isDownloadingOrPaused ? "3 MB/s   ·   " : ""}"
                                    "${DateFormat('MMM dd yyyy').format(widget.item.datetime)}   ·   " +
                                (widget.item.isDownloading ? "40 min" : describeEnum(widget.item.status).capitalize),
                            style: context.textTheme.bodyText2!.copyWith(fontSize: 12),
                          ),
                        ],
                      )),
                      if (widget.item.isCompleted) ...[
                        const Icon(Ionicons.folder_outline, size: 20),
                        const SizedBox(width: 15),
                        const Icon(Ionicons.open_outline, size: 20),
                        const SizedBox(width: 15),
                      ] else if (widget.item.isCancelled) ...[
                        const Icon(Icons.restart_alt_outlined, size: 20),
                        const SizedBox(width: 15),
                      ],
                      if (widget.item.isDownloadingOrPaused) ...[
                        Icon(
                          widget.item.isPaused ? Ionicons.play_outline : Ionicons.pause_outline,
                          size: 20,
                        ),
                        const SizedBox(width: 15),
                        const Icon(Ionicons.close_outline, size: 20),
                      ] else ...[
                        const Icon(Ionicons.trash_bin_outline, size: 20),
                      ],
                    ],
                  ),
                  if (widget.item.isDownloadingOrPaused)
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: LinearProgressIndicator(
                        value: widget.item.actual / widget.item.total,
                        backgroundColor: context.isDark ? Colors.grey[700] : Colors.grey[50],
                        color: widget.item.status == DownloadStatus.paused ? Colors.grey : context.primaryColor,
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
