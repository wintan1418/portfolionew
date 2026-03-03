module Admin
  class PostsController < BaseController
    before_action :set_post, only: [ :edit, :update, :destroy, :publish, :unpublish ]

    def index
      @posts = Post.order(created_at: :desc)
    end

    def new
      @post = Post.new
    end

    def create
      @post = Post.new(post_params)
      if @post.save
        redirect_to admin_posts_path, notice: "Post created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @post.update(post_params)
        redirect_to admin_posts_path, notice: "Post updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @post.destroy
      redirect_to admin_posts_path, notice: "Post deleted."
    end

    def publish
      @post.update(status: "published", published_at: Time.current)
      redirect_to admin_posts_path, notice: "Post published."
    end

    def unpublish
      @post.update(status: "draft", published_at: nil)
      redirect_to admin_posts_path, notice: "Post unpublished."
    end

    private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(
        :title, :slug, :excerpt, :status, :published_at, :featured,
        :meta_title, :meta_description, :og_title, :og_description,
        :category_id, :cover_image, :body
      )
    end
  end
end
