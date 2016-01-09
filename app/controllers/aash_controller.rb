class AashController < ApplicationController
  
  before_filter :authenticate_user!
  
  def show

   if(current_user.bool_first_login == "yes")
     
     if(current_user.type == "student")               #student
        @ongoing_tasks = Assign.where(:teacher_id => current_user.teacher_id)
        current_user.bool_first_login = "no"
        current_user.save
        render :student2
     else                                             #teacher
        current_user.bool_first_login = "no"
        current_user.save
        
        @message = current_user.no_of_student.to_s + " student ids have been generated and mailed to " + current_user.email.to_s
        $i = 0
        $num =  current_user.no_of_student.to_i()
        while $i< $num

          $randid =  current_user.name + current_user.school_name[0..2] +(rand(0)+9).to_i.to_s + $i.to_s()
          $randpass = wordwithnumber(["happy","cat","dog","apple","banana","hair","mail"])
          $rand_parent_key = wordwithnumber(["bottle","chair","house","orange","black","bag","table"])
          $teacher_id = current_user.name 
          $teacher_name = current_user.real_name

          #create student
          User.new({:name => $randid, :email => "notset",:type => 'student' ,:school_name => current_user.school_name ,:class_name => current_user.class_name ,:teacher_id => $teacher_id, :teacher_name => $teacher_name , :unenc_pass => $randpass ,:password => $randpass, :password_confirmation => $randpass, :secret_key => $rand_parent_key }).save(:validate => false)
          $i=$i+1
        
        end # whileaD
        

        UserMailer.sendpass(current_user).deliver
        
        redirect_to :controller => :teacher , :action => :index
    
     end # student or teacher
  
   else   # NOT first Login
      if(current_user.type == "student") 

        @ongoing_tasks = Assign.where(:teacher_id => current_user.teacher_id)

        if(current_user.real_name == "")
          redirect_to edit_user_registration_path
        else
           render :student2 , :layout => false
        end
      else
        redirect_to :controller => :teacher , :action => :index
      end 
     
   end # first login or not 
   
   
  end # def show
  
  def random_pronouncable_password(size = 4)
    c = %w(b c d f g h j k l m n p qu r s t v w x z ch cr fr nd ng nk nt ph pr rd sh sl sp st th tr)
    v = %w(a e i o u y)
    f, r = true, ''
    (size * 2).times do
      r << (f ? c[rand * c.size] : v[rand * v.size])
      f = !f
    end
    r
  end
  
  def wordwithnumber(words)
     words[rand(words.length)]+(rand(0)+99).to_i.to_s()
  end

   
end
