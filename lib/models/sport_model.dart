import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SportModel {
  int id;
  String title;
  String description;
  String content;
  String thumb;
  String link;
  SportModel({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.thumb,
    required this.link,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'content': content,
      'thumb': thumb,
      'link': link,
    };
  }

  factory SportModel.fromMap(Map<String, dynamic> map) {
    return SportModel(
      id: map['id'] as int,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      content: map['content'] ?? '',
      link: map['link'] ?? '#',
      thumb: map['thumb'] ??
          'https://images.unsplash.com/photo-1687777239213-45fa97d7cf9d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0Nzc2Nzd8MHwxfHJhbmRvbXx8fHx8fHx8fDE2ODk5NjA3Nzh8&ixlib=rb-4.0.3&q=80&w=1080',
    );
  }

  String toJson() => json.encode(toMap());

  factory SportModel.fromJson(String source) =>
      SportModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
