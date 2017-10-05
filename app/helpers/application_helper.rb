module ApplicationHelper

  def send_notification car
    @subscriptions = Subscription.where(:car_id => car.id)
    @subscriptions.each do |subscription|
      @user = User.find(subscription.user_id)
      subscription.destroy
    end
  end

end
