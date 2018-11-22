class TripMailer < ApplicationMailer

  default from: 'trips@sandboxe6920535e59a48539a206fb0dc04a128.mailgun.org'

  def trip_email_start
    @trip = params[:trip]
    @recipient = params[:contact]
    @user = User.find(@trip.user_id)
    mail(
        to: @recipient.email,
        subject: "#{@user.first_name} has started their trip!"
    )
  end

  def trip_email_end
    @trip = params[:trip]
    @recipient = params[:contact]
    @user = User.find(@trip.user_id)
    mail(
        to: @recipient.email,
        subject: "#{@user.first_name} has arrived at their destination!"
    )
  end

  def trip_email_cancel
    @trip = params[:trip]
    @recipient = params[:contact]
    @user = User.find(@trip.user_id)
    mail(
        to: @recipient.email,
        subject: "#{@user.first_name} has cancelled their trip!"
    )
  end
end
