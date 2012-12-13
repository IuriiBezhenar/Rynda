class UserMailer < ActionMailer::Base
  default :from => "admin@fortuna.odessa.ua"
  #Const::STR_VALUE_DEFAULT_MAIL_SENDER

  def notify(user, subj, text)
    mail(:to => user.email, :subject => subj) do |format|
      format.text { render :text => text }
    end.deliver
  end

end
