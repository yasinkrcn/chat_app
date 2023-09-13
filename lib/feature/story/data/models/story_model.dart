import 'dart:convert';

import 'package:chat_app/core/_core_exports.dart';

class StoryModel {
  final String? storyUrl;
  final String? storySender;
  final Timestamp? sentTime;
  StoryModel({
    this.storyUrl,
    this.storySender,
    this.sentTime,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'storyUrl': storyUrl});
    result.addAll({'storySender': storySender});
    result.addAll({'sentTime': sentTime});

    return result;
  }

  factory StoryModel.fromMap(Map<String, dynamic> map) {
    return StoryModel(
      storyUrl: map['storyUrl'] ?? '',
      storySender: map['storySender'] ?? '',
      sentTime: map['sentTime'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StoryModel.fromJson(String source) => StoryModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StoryModel &&
        other.storyUrl == storyUrl &&
        other.storySender == storySender &&
        other.sentTime == sentTime;
  }

  @override
  int get hashCode => storyUrl.hashCode ^ storySender.hashCode ^ sentTime.hashCode;
}
