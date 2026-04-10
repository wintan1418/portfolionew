module Admin
  class DashboardController < BaseController
    def index
      @profile = Profile.instance

      # Analytics
      @total_views = PageView.count
      @views_today = PageView.today.count
      @views_this_week = PageView.this_week.count
      @views_this_month = PageView.this_month.count
      @popular_pages = PageView.where(created_at: 30.days.ago..).group(:path).order("count_all desc").limit(10).count

      # Content stats
      @projects_count = Project.count rescue 0
      @posts_count = Post.count rescue 0
      @subscriber_count = Subscriber.active.count
      @contacts_count = Contact.count rescue 0

      # Comments
      @pending_comments_count = Comment.pending.count

      # Recent activity
      @recent_contacts = Contact.order(created_at: :desc).limit(5)
    end
  end
end
