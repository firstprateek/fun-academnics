class Userdata
  include Mongoid::Document
  field :studentid, :type => String
  field :studentname,:type => String
  field :teacherid , :type => String
  field :teachername, :type => String
  
  field :points, :type => String
  field :total_time_played, :type => String
  field :accuracy , :type => String
  field :level_String, :type => String
end
