class TripMailer < ApplicationMailer

  default from: 'trips@accessibuild.com'

  def trip_email_start
    # Example until api calls have been ironed out
    # Also add address of destination to email
    @user = User.find(params:[:user_id])
    @recipients = getIncludedContacts(params:[:trip_id])
    mail(
        to: @recipients.map(&:email).uniq,
        subject: "#{@user.first_name} has started their trip!"
      )
  end

  def trip_email_end
    @user = User.find(params:[:user_id])
    @recipients = getIncludedContacts(params:[:trip_id])
    mail(
        to: @recipients.map(&:email).uniq,
        subject: "#{@user.first_name} has arrived at their destination!"
      )
  end

  def trip_email_cancel
    @user = User.find(params:[:user_id])
    @recipients = getIncludedContacts(params:[:trip_id])
    mail(
        to: @recipients.map(&:email).uniq,
        subject: "#{@user.first_name} has cancelled their trip!"
      )

  end

  private
    def getIncludedContacts(tripid)
      # Should return join table, but not individual contacts for now
      @contacts = Trip.find(tripid).companions
    end
end
