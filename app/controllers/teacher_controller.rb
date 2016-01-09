class TeacherController < ApplicationController

  before_filter :set_cache_buster

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
  
  def index

    @teacher = current_user

    if(current_user.to_s == "")
      redirect_to :controller => :home , :action => :index
    else
    ############### Find out available tasks which teacher can assign ############

    @tasks = Game.where({:grade => @teacher.class_name})
    @available_tasks = [] # Will be used to render available tasks which teacher can assign right now

    i = 0

    while i < @tasks.count do
      if (Assign.where(:teacher_id => @teacher.name, :game_id => @tasks[i].game_id).first == nil)
        @available_tasks.push(@tasks[i])
      end
      i = i + 1
    end

    ############### Find out ongoing tasks which students are attempting and teacher can end ############

    @ongoing_tasks = Assign.where(:teacher_id => @teacher.name)

    ############### Find out progress of ongoing tasks ############

    @games_assigned = Assign.where({:teacher_id => @teacher.name})
    @students_list = User.where({:teacher_id => @teacher.name})

    @latest_progress_details = {}

    j = 0
    @games_assigned.each do |game_details|

      @latest_progress_details[@games_assigned[j].game_id] = []

      
      @students_list.each do |student_details|

        @real_name = student_details.real_name # Name of student
        @levels = Ongoing.where({:student_id => student_details.name, :game_id => game_details.game_id}) # Get all levels and generate an array with CSVs

        if (@levels.count > 0)
          i = 0
          while i < @levels.count do
            @latest_progress_details[@games_assigned[j].game_id].push(@real_name + "," + @levels[i].level_name.to_s + "," + @levels[i].score.to_s + "," + @levels[i].accuracy.to_s)
            i = i + 1
          end
        else
          if (@real_name.to_s != "")
            @latest_progress_details[@games_assigned[j].game_id].push(@real_name + ',NOT PLAYED,0,0')
          end
        end
      end
      j = j + 1
    end

    ############### See progress history of student ############

    # @students_list already set in above block
  end
  end

  def make_assignment

    @teacher_id = params[:teacher_id]
    @game_id = params[:game_id]

    render :layout => false
  end

  def assign_task
  	# Make DB entry

    if (params[:teacher_id] == nil)
      params[:teacher_id] = params[:form][:teacher_id]
    end

    if (params[:game_id] == nil)
      params[:game_id] = params[:form][:game_id]
    end

  	@data = Assign.where({:teacher_id => params[:teacher_id], :game_id => params[:game_id]}).find_or_create_by({:teacher_id => params[:teacher_id], :game_id => params[:game_id]})

    @file_path = Rails.public_path + "/" + params[:teacher_id] + "_" + params[:game_id] + ".xml"
    @file_url = params[:teacher_id] + "_" + params[:game_id] + ".xml"

    
    if (params[:form] != nil)
      if (params[:form][:text_file].to_s != "")
        flag = true
        count = 1
        if(File.extname(params[:form][:text_file].original_filename) != ".txt")
          flag = false
        else
          File.open(@file_path , 'w') {|f| f.write(params[:form][:text_file].read) }
          File.open(@file_path, "r").each_line do |line|
            data = line.split(/\t/)
            if(count <= 2)
              if(data.to_s.split(",").length != 1)
                flag = false
              end
            else
              if(data.to_s.split(",").first == "[\"mcq")
                  if(data.to_s.split(",").length != 6)
                    flag = false;   
                  end     
              elsif(data.to_s.split(",").first == "[\"text")
                  if(data.to_s.split(",").length != 3)
                    flag = false;
                  end
              else
                flag = false;
              end
            end
            count = count+1
          end
  #      binding.pry
        end
      end
    else
      flag = true
    end



    @data.teacher_id = params[:teacher_id]
    @data.game_id = params[:game_id]
    @data.type = Game.where(:game_id => params[:game_id]).first.type
    @data.game_name = Game.where(:game_id => params[:game_id]).first.game_name
    @data.url = @file_url
    if (flag)
      @data.save
      redirect_to :controller=>'teacher', :action => 'index'
    else
      @data.delete
      $teacher_error_message = "Please upload file with correct format."
      redirect_to :controller=>'teacher', :action => 'make_assignment', :teacher_id => params[:teacher_id], :game_id => params[:game_id]
    end
  end

  def remove_task
    # Remove DB entry
    @data = Assign.where({:teacher_id => params[:teacher_id], :game_id => params[:game_id]}).delete

    Ongoing.where({:teacher_id => params[:teacher_id], :game_id => params[:game_id]}).delete

    redirect_to :controller=>'teacher', :action => 'index'
  end

  def view_progress
    # Give one ID and see whole progress of that studens

    @progress_list = Performance.where({:student_id => params[:student_id], :teacher_id => current_user.name})
    
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