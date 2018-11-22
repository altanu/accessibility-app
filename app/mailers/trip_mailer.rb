class TripMailer < ApplicationMailer

  default from: 'trips@sandboxe6920535e59a48539a206fb0dc04a128.mailgun.org'

  # IF the email is only being sent to one perseon, try looping this entire function instead of the internals

  def trip_email_start
    # Example until api calls have been ironed out
    # Also add address of destination to email
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

  private # Might remove if its easy to get contacts
    def getIncludedContacts(tripid)
      # Should return join table, but not individual contacts for now
      @contacts = Trip.find(tripid).companions
    end
end
