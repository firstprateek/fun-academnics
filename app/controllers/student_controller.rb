class StudentController < ApplicationController
  def show
  end

  def index
  	@ongoing_tasks = Assign.where(:teacher_id => current_user.teacher_id)

  	render :layout => false
  end

   def view_progress
    # Give one ID and see whole progress of that studens

    @progress_list = Performance.where({:student_id => current_user.name, :teacher_id => current_user.teacher_id})
    
    @progress_dict = {}

    @progress_list.each do |progress_item|

      if (@progress_dict[progress_item.game_id] == nil)
        @progress_dict[progress_item.game_id] = []
      end

      @progress_dict[progress_item.game_id].push(progress_item)

    end

    render :layout => false
  end

end
