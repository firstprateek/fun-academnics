class UserMailer < ActionMailer::Base
  
  def sendpass(user)
    @user = user 
    mail(:from =>"nikhil@google.com",:to => user.email, :subject => "Registered Successfully")  
  end

  def sendkey(user, new_name, new_parent_email)
    @user = user
    @new_student_id = new_name
 
    mail(:from =>"nikhil@google.com",:to => new_parent_email.to_s, :subject => "See Progress Of Your Child")  
  end
end
