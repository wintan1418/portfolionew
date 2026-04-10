class CommentsController < ApplicationController
  allow_unauthenticated_access

  def create
    @post = Post.published.find_by!(slug: params[:post_slug])
    @comment = @post.comments.build(comment_params)

    if @comment.save
      redirect_to blog_post_path(@post.slug), notice: "Comment posted!"
    else
      @comments = @post.comments.top_level.oldest_first.includes(:replies)
      @liked = @post.post_likes.exists?(session_id: like_session_id)
      @related_posts = Post.published
                          .where(category: @post.category)
                          .where.not(id: @post.id)
                          .order(published_at: :desc)
                          .limit(3) if @post.category
      flash.now[:alert] = "Please fix the errors below."
      render "posts/show", status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:author_name, :author_email, :body, :parent_id)
  end

  def like_session_id
    session[:like_token] ||= SecureRandom.uuid
  end
  helper_method :like_session_id
end
