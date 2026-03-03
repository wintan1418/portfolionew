class SubscribersController < ApplicationController
  allow_unauthenticated_access

  def create
    @subscriber = Subscriber.new(subscriber_params)

    if @subscriber.save
      SubscriberWelcomeJob.perform_later(@subscriber)
      redirect_back fallback_location: root_path, notice: "Thanks for subscribing! You'll hear from us soon."
    else
      redirect_back fallback_location: root_path, alert: "Could not subscribe. Please try again."
    end
  end

  def unsubscribe
    @subscriber = Subscriber.find_by(token: params[:token])

    if @subscriber
      @subscriber.update(status: "unsubscribed")
      redirect_to root_path, notice: "You have been unsubscribed."
    else
      redirect_to root_path, alert: "Invalid unsubscribe link."
    end
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:email, :name)
  end
end
