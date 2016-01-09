class ParentController < ApplicationController
  
   before_filter :set_cache_buster

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def index

  	if ($parent_message == nil)
  		$parent_message = ""
  	end

  end

  def view_progress

  	@user = User.where({:name => params[:student_id], :secret_key => params[:parent_key]}).first

  	if (@user != nil)

  		$parent_message = ""

	  	@progress_list = Performance.where({:student_id => @user.name, :teacher_id => @user.teacher_id})
	    
	    @progress_dict = {}

	    @progress_list.each do |progress_item|

	      if (@progress_dict[progress_item.game_id] == nil)
	        @progress_dict[progress_item.game_id] = []
	      end

	      @progress_dict[progress_item.game_id].push(progress_item)

	    end

	    render :layout => false
	else

		$parent_message = "Please re-enter correct credentials."

		redirect_to :controller => :parent , :action => :index
 	end

  end
end
