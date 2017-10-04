class CustomerMailer < ApplicationMailer
  def car_return_notification(user, car, reservation)
    @user = user
    @car = car
    @reservation = reservation
    mail to: user.email, subject: 'Reservation time has ended'
  end
end
