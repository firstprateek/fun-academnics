class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ####  Commons ############################################
  field :name 
  field :email,              :type => String, :null => false, :default => ""
  field :real_name,          :type => String
  field :encrypted_password, :type => String, :null => false, :default => ""
  field :school_name,        :type => String
  field :class_name,         :type => String

  field :type,               :type => String , :default => "teacher"
  field :bool_first_login,   :type => String , :default => "yes"
  
  ####  Teacher
  field :no_of_student,     :type => String

  ####  Students
  field :teacher_id,        :type => String
  field :teacher_name,      :type => String
  field :unenc_pass,        :type => String
  
  #### Parent
  field :secret_key,        :type => String
  field :parent_email,        :type => String

  #data
  
  field :points,             :type => String ,:default => "0"
  field :total_time_played,  :type => String ,:default => "00:00:00"
  field :accuracy ,          :type => String ,:default => "0"
  field :level_String,       :type => String ,:default => "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
  field :time_String,       :type => String ,:default => "00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00"
  field :total_correct ,     :type => String ,:default => "0"
  field :total_wrong ,     :type => String ,:default => "0"
  ############################################################
  
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Encryptable
  # field :password_salt, :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String
  

  validates_presence_of :name, :real_name, :parent_email
  validates_uniqueness_of :name, :email, :case_sensitive => false
  attr_accessible :name, :email, :real_name, :password, :password_confirmation, :remember_me, :school_name, :class_name, :no_of_student, :type, :bool_student_gen,:bool_first_login,:unenc_pass,:teacher_id,:teacher_name,:points,:total_time_played,:accuracy,:level_String, :time_String, :secret_key, :parent_email
  validates_format_of :parent_email, :with  => Devise.email_regexp
  after_validation :do_something_if_validation_fails, :unless => lambda { errors.empty? }

def update_with_password(params={}) 
    if params[:password].blank? 
      params.delete(:password) 
      params.delete(:password_confirmation) if params[:password_confirmation].blank? 
    end 
    update_attributes(params) 
end

def do_something_if_validation_fails
  $validation_bool = false
end



end

