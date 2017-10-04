class CustomerMailer < ApplicationMailer
  def car_return_notification(user, car, reservation)
    @user = user
    @car = car
    @reservation = reservation
    mail to: user.email, subject: 'Someone wants to join your carpool!'
  end
end
