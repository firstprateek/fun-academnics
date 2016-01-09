class HomeController < ApplicationController
  def index
    @users = User.all
    render :index , :layout => false
    
  end
  
  def index2
  
  render :index2 , :layout => false  
    
  end
  
  def showmathfact
    render :mathfact, :layout =>false
  
  end
  
  def team
    
    render :team, :layout => false
    
  end

  def checkUser
    render :checkUser, :layout =>false;

  end

  def change_password
    # Give one ID and see whole progress of that studens

    if(params[:userID] == "teacher")
      redirect_to '/users/password/new'
    else
      @success = 0;
      render :studentForgot, :layout => false;
    end
  end

  def change_password_student
    # Give one ID and see whole progress of that studens

    @data = User.where({:name => params[:studentID]})
    if(@data.first == nil)
      @message = "The Username does not exist, please try again"
      @success = 0
      render :studentForgot, :layout => false;
    else
      userData = @data.first
      userData.password = userData.unenc_pass
      userData.password_confirmation = userData.unenc_pass
      userData.save
      @success = 1
      @message = "Your password has been reset to the original. Consult your teacher if you don't remember it"
      render :studentForgot, :layout => false;
    end
  end
end
