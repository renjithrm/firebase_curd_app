class UserModel {
  String? uid;
  String? title;
  String? content;
  UserModel({
    this.uid,
    this.title,
    this.content,
  });
  UserModel fromJson(Map<String, dynamic> json, String id) => UserModel(
        uid: id,
        title: json["title"],
        content: json["content"],
      );
  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
      };
}
