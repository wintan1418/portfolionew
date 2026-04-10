module Admin
  class CommentsController < BaseController
    before_action :set_comment, only: [ :approve, :reject, :destroy ]

    def index
      @comments = Comment.includes(:post).order(created_at: :desc)
      @comments = @comments.where(approved: params[:status] == "approved") if params[:status].present?
    end

    def approve
      @comment.update!(approved: true)
      redirect_to admin_comments_path, notice: "Comment approved."
    end

    def reject
      @comment.update!(approved: false)
      redirect_to admin_comments_path, notice: "Comment rejected."
    end

    def destroy
      @comment.destroy
      redirect_to admin_comments_path, notice: "Comment deleted."
    end

    private

    def set_comment
      @comment = Comment.find(params[:id])
    end
  end
end
