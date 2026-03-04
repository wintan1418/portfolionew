module Admin
  class NewslettersController < BaseController
    before_action :set_newsletter, only: [ :edit, :update, :destroy, :send_newsletter ]

    def index
      @newsletters = Newsletter.recent
    end

    def new
      @newsletter = Newsletter.new
    end

    def create
      @newsletter = Newsletter.new(newsletter_params)
      if @newsletter.save
        redirect_to admin_newsletters_path, notice: "Newsletter created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @newsletter.update(newsletter_params)
        redirect_to admin_newsletters_path, notice: "Newsletter updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @newsletter.destroy
      redirect_to admin_newsletters_path, notice: "Newsletter deleted."
    end

    def send_newsletter
      if @newsletter.draft?
        NewsletterBroadcastJob.perform_later(@newsletter)
        @newsletter.update(status: "sent", sent_at: Time.current, recipients_count: Subscriber.active.count)
        redirect_to admin_newsletters_path, notice: "Newsletter is being sent to #{@newsletter.recipients_count} subscribers."
      else
        redirect_to admin_newsletters_path, alert: "Newsletter has already been sent."
      end
    end

    private

    def set_newsletter
      @newsletter = Newsletter.find(params[:id])
    end

    def newsletter_params
      params.require(:newsletter).permit(:subject, :body)
    end
  end
end
