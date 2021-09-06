import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

enum FileType { audio, video, compressed, image, program, other }

extension FileTypeExtensions on FileType {
  Color get getColor => this == FileType.audio
      ? Colors.purple[600]!
      : this == FileType.video
          ? Colors.blue[600]!
          : this == FileType.compressed
              ? Colors.brown[600]!
              : this == FileType.image
                  ? Colors.orange[600]!
                  : this == FileType.program
                      ? Colors.green[700]!
                      : Colors.blueGrey[600]!;
  get getIconData => this == FileType.audio
      ? Ionicons.musical_note_outline
      : this == FileType.video
          ? Ionicons.videocam_outline
          : this == FileType.compressed
              ? Ionicons.archive_outline
              : this == FileType.image
                  ? Ionicons.image_outline
                  : this == FileType.program
                      ? Ionicons.cube_outline
                      : Ionicons.help_outline;

  get getIcon => Icon(
        getIconData,
        color: Colors.white,
        size: 23,
      );
}
