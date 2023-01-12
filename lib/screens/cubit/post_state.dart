part of 'post_cubit.dart';

@immutable
abstract class PostState {
  final int entries;

  const PostState(this.entries);
}

class PostInitial extends PostState {
  const PostInitial(int entries) : super(entries);
}

class PostLoaded extends PostState {
  final List<Post> posts;
  final int currentPage;
  final int totalPages;

  const PostLoaded(this.posts, this.currentPage, this.totalPages, int entries)
      : super(entries);
}

class PostError extends PostState {
  const PostError(int entries) : super(entries);
}
