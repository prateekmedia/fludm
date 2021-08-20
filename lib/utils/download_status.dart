enum DownloadStatus { downloading, paused, cancelled, complete }

extension DownloadStatusExtension on DownloadStatus {
  bool get isDownloading => index <= 1 ? true : false;
}
