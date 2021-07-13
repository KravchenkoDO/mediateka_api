json.user_movie_comments @user_movie_comments do |user_movie_comment|
  json.id user_movie_comment.id
  json.comment user_movie_comment.comment
  json.rating user_movie_comment.rating
end
