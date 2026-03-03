module Admin
  class SubscribersController < BaseController
    def index
      @subscribers = Subscriber.order(created_at: :desc)
    end

    def destroy
      Subscriber.find(params[:id]).destroy
      redirect_to admin_subscribers_path, notice: "Subscriber removed."
    end

    def export
      @subscribers = Subscriber.active.order(:created_at)
      csv_data = CSV.generate(headers: true) do |csv|
        csv << [ "Email", "Name", "Status", "Subscribed At" ]
        @subscribers.each do |sub|
          csv << [ sub.email, sub.name, sub.status, sub.created_at ]
        end
      end
      send_data csv_data, filename: "subscribers-#{Date.current}.csv"
    end
  end
end
