class LoggerController < ApplicationController

  def logthis
    
    @data = Performance.where({:student_id => params[:student_id],
      :game_id => params[:game_id], :level_name => params[:level_name], :teacher_id => params[:teacher_id]}).find_or_create_by({:student_id => params[:student_id],
      :game_id => params[:game_id], :level_name => params[:level_name], :teacher_id => params[:teacher_id]})

    @data.count = @data.count + 1
    @data.accuracy = (@data.accuracy * (@data.count - 1) + params[:accuracy].to_f) / @data.count
    if (params[:score].to_i > @data.score)
      @data.score = params[:score].to_i
    end

    @data.save

    @student_data = User.where({:name => params[:student_id]}).first
    @student_data.points = Performance.where({:student_id => params[:student_id]}).sum(:score).to_i

    @student_data.save

    @ongoing_data = Ongoing.where({:student_id => params[:student_id],
      :game_id => params[:game_id], :level_name => params[:level_name], :teacher_id => params[:teacher_id]}).find_or_create_by({:student_id => params[:student_id],
      :game_id => params[:game_id], :level_name => params[:level_name], :teacher_id => params[:teacher_id]})

    @ongoing_data.count = @ongoing_data.count + 1
    @ongoing_data.accuracy = (@ongoing_data.accuracy * (@ongoing_data.count - 1) + params[:accuracy].to_f) / @ongoing_data.count
    if (params[:score].to_i > @ongoing_data.score)
      @ongoing_data.score = params[:score].to_i
    end

    @ongoing_data.save

    #binding.pry

    render :logthis, :layout => false
  end
  
  def getdata
    @action = params[:action_type]
    @id = params[:studentid]
    if(@action == "load")
      render :progress, :layout => false
    else
      @student = User.where(:name => @id).first
      
      @student.points = params[:points]
      @student.accuracy = params[:accuracy]
      @student.total_time_played = params[:totalTime]
      @student.level_String = params[:levelString]
      @student.total_correct = params[:totalCorrect]
      @student.total_wrong = params[:totalWrong]
      @student.time_String = params[:timeString]
      @student.save
      render :progress, :layout => false  
    end  
    
  end
  def crossdomain
    render :cross , :layout => false
    
  end
  
  def game

    @game_id = params[:game_id]

    render :game , :layout => false
  end  
  
  def freeplay
    render :freeplay , :layout => false
  end
  
  def showdetails
    @stud_id = request.query_string.to_s
    
    render :details , :layout => false
  end  
end
 