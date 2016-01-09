class Performance
	include Mongoid::Document
	field :score, :type => Integer, :default => 0
	field :type,:type => String
	field :level_name , :type => String
	field :game_id, :type => String
	field :game_name, :type => String
	field :student_id, :type => String
	field :accuracy, :type => Float, :default => 0
	field :count, :type => Integer, :default => 0
	field :taecher_id, :type => String
end
