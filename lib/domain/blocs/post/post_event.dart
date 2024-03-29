part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class OnPrivacyPostEvent extends PostEvent {
  final int privacyPost;

  OnPrivacyPostEvent(this.privacyPost);
}

class OnSelectedImageEvent extends PostEvent {
  final File imageSelected;

  OnSelectedImageEvent(this.imageSelected);
}

class OnClearSelectedImageEvent extends PostEvent {
  final int indexImage;

  OnClearSelectedImageEvent(this.indexImage);
}

class OnAddNewPostEvent extends PostEvent {
  final String description;

  OnAddNewPostEvent(this.description);
}

class OnSavePostByUser extends PostEvent {
  final String idPost;
  final String type;

  OnSavePostByUser(this.idPost, this.type);
}

class OnUnSavePostByUser extends PostEvent {
  final String postSaveId;

  OnUnSavePostByUser(this.postSaveId);
}

class OnIsSearchPostEvent extends PostEvent {
  final bool isSearchFriend;

  OnIsSearchPostEvent(this.isSearchFriend);
}

class OnNewStoryEvent extends PostEvent {}

class OnLikeOrUnLikePost extends PostEvent {
  final String uidPost;
  final String type;

  OnLikeOrUnLikePost(this.uidPost, this.type);
}

class OnAddNewCommentEvent extends PostEvent {
  final String uidRecipe;
  final String comment;

  OnAddNewCommentEvent(this.uidRecipe, this.comment);
}

class OnLikeOrUnlikeComment extends PostEvent {
  final String uidComment;

  OnLikeOrUnlikeComment(this.uidComment);
}

class OnGetAllPostHome extends PostEvent {
  final String uidHome;
  OnGetAllPostHome(this.uidHome);
}
