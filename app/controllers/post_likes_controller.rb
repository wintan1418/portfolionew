class PostLikesController < ApplicationController
  allow_unauthenticated_access

  def toggle
    @post = Post.published.find_by!(slug: params[:post_slug])
    session_id = like_session_id

    existing = @post.post_likes.find_by(session_id: session_id)
    if existing
      existing.destroy
      liked = false
    else
      @post.post_likes.create!(session_id: session_id)
      liked = true
    end

    @post.reload
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "like-button-#{@post.id}",
          partial: "posts/like_button",
          locals: { post: @post, liked: liked }
        )
      end
      format.html { redirect_to blog_post_path(@post.slug) }
    end
  end

  private

  def like_session_id
    session[:like_token] ||= SecureRandom.uuid
  end
end
