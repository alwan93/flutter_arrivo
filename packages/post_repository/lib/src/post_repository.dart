import 'dart:async';

import 'package:post_repository/post_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PostRepository {
  final String hostBaseUrl = 'https://jsonplaceholder.typicode.com';

  // final String hostBaseUrl;
  final Dio _dio = Dio();
  final storage = const FlutterSecureStorage();

  // PostRepository({required this.hostBaseUrl});

  Future<List<Post>> getPost() async {
    try {
      final hostUrl = hostBaseUrl;
      Response<dynamic> response;
      response = await _dio.get('$hostUrl/posts');

      if (response.data != null && response.data.length > 1) {
        final data = response.data as List;
        return data.map((post) => Post.fromMap(post)).toList();
      } else {
        return [];
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);

        if (e.response?.data?['error'] == 'Bad Request') {
          throw Exception(e.message);
        }
        throw Exception('Something went wrong');
      } else {
        print(e.requestOptions);
        print(e.message);
        throw Exception('Received null from API');
      }
    }
  }
}
