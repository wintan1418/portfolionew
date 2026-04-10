module Admin
  class CommentsController < BaseController
    def index
      @comments = Comment.includes(:post).order(created_at: :desc)
    end

    def destroy
      Comment.find(params[:id]).destroy
      redirect_to admin_comments_path, notice: "Comment deleted."
    end
  end
end
