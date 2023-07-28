class Comment {
  String? user;
  String? comment;
  String? id;

  Comment({this.user, this.comment, this.id});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      user: json['user'],
      comment: json['comment'],
      id: json['_id'],
    );
  }
}
