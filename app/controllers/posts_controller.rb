class PostsController < ApplicationController
  include Pagy::Backend
  allow_unauthenticated_access

  def index
    posts = Post.recent

    if params[:search].present?
      posts = posts.where("title ILIKE :q OR excerpt ILIKE :q", q: "%#{params[:search]}%")
    end

    if params[:category].present?
      @category = Category.find_by(slug: params[:category])
      posts = posts.where(category: @category) if @category
    end

    @pagy, @posts = pagy(posts, limit: 9)
    @featured_post = Post.published.featured.order(published_at: :desc).first unless params[:search].present? || params[:category].present?
    @categories = Category.ordered
    set_meta_tags(title: "Blog")
  end

  def show
    @post = Post.published.find_by!(slug: params[:slug])
    @related_posts = Post.published
                        .where(category: @post.category)
                        .where.not(id: @post.id)
                        .order(published_at: :desc)
                        .limit(3) if @post.category
    set_meta_tags(
      title: @post.meta_title.presence || @post.title,
      description: @post.meta_description.presence || @post.excerpt
    )
  end

  def category
    @category = Category.find_by!(slug: params[:slug])
    @pagy, @posts = pagy(Post.published.where(category: @category).order(published_at: :desc), limit: 9)
    @categories = Category.ordered
    set_meta_tags(title: "Blog — #{@category.name}")
    render :index
  end

  def feed
    @posts = Post.recent.limit(20)
    @profile = Profile.instance
    respond_to do |format|
      format.rss { render layout: false }
    end
  end
end
