class Assign
  include Mongoid::Document
  field :teacher_id, :type => String
  field :game_id, :type => String
  field :type, :type => String
  field :game_name, :type => String
  field :url, :type => String
end
