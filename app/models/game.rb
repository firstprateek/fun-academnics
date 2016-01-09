class Game
	include Mongoid::Document
	field :game_id,:type => String
	field :grade, :type => String
	field :type, :type => String, :default => "game"
	field :game_name, :type => String
	field :url, :type => String
end
