import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:post_repository/post_repository.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit(this._postRepository) : super(const PostInitial(15));

  final PostRepository _postRepository;

  Future<void> fetchPosts(
      {int entries = 15, int currentPage = 1, String searchTerm = ''}) async {
    emit(const PostInitial(15));

    try {
      List<Post> result = await _postRepository.getPost();
      if (searchTerm != '') {
        result = result.where((obj) => obj.body.contains(searchTerm)).toList();
      }
      final totalPages = (result.length / entries).ceil();
      final offset = (entries * currentPage) - entries;
      int limit = entries * currentPage;

      if (currentPage == totalPages) {
        limit = result.length - offset;
      } else if (totalPages == 0) {
        result = [];
      } else {
        result = result.sublist(offset, limit);
      }

      emit(PostLoaded(result, currentPage, totalPages, entries));
    } catch (e) {
      emit(const PostError(15));
    }
  }

  Future<void> sendPost(Post newPost) async {
    try {
      Map<String, dynamic> result =
          await _postRepository.submitPost(data: newPost);
      print(result);
    } catch (err) {
      print(err);
    }
  }
}
