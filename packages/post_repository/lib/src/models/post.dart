import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int postID;
  final String title;
  final String body;
  final int userID;

  const Post({
    this.postID = 0,
    this.title = '',
    this.userID = 0,
    this.body = '',
  });

  static Post fromMap(Map<dynamic, dynamic> data) {
    return Post(
      postID: data['id'],
      title: data['title'],
      body: data['body'],
      userID: data['userId'],
    );
  }

  Post copyWith({
    int? postID,
    String? title,
    String? body,
    int? userID,
  }) {
    return Post(
        postID: postID ?? this.postID,
        title: title ?? this.title,
        body: body ?? this.body,
        userID: userID ?? this.userID);
  }

  Map<String, dynamic> toJson() {
    return {'post_id': postID, 'title': title, 'body': body, 'userID': userID};
  }

  static List<Post> fromJson({List<dynamic> searchResults = const []}) {
    if (searchResults.isNotEmpty) {
      List<Post> posts = searchResults
          .map((searchResult) => Post(
                postID: searchResult['post_id'] ?? '',
                title: searchResult['name'] ?? '',
                body: searchResult['body'] ?? '',
                userID: searchResult['userID'] ?? '',
              ))
          .toList();

      return posts;
    }
    return [];
  }

  @override
  List<Object?> get props => [postID, title, body, userID];
}
