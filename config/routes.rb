Rails3MongoidDevise::Application.routes.draw do
  
  get "parent/index"

  # Actions of teacher
  get "teacher/assign_task" => "teacher#assign_task"
  post "teacher/assign_task" => "teacher#assign_task"
  get "teacher/pick_student" => "teacher#pick_student"
  get "teacher/view_progress" => "teacher#view_progress"
  get "teacher/view_latest_progress" => "teacher#view_latest_progress"
  get "teacher/show_tasks" => "teacher#show_tasks"
  get "teacher/remove_task" => "teacher#remove_task"
  get "teacher/make_assignment" => "teacher#make_assignment"
  get "teacher/index" => "teacher#index"

  # Actions of student
  get "student/index" => "student#index"
  get "student/view_progress" => "student#view_progress"

  get "/users/password/change_password" => "home#change_password"
  get "/users/password/change_password_student" => "home#change_password_student"
  # Actions of parent
  get "parent/index" => "parent#index"
  get "parent/view_progress" => "parent#view_progress"

  get "login/login"

  get "login_controller/login"

  get "logger/logthis"

  get "student/show"
  get "teacher/show"

 
  authenticated :user do
    root :to => 'aash#show'
  end
  
  root :to => "home#index"

  devise_for :users, :controllers => {:registrations => "registrations"} do
    get "/users/sign_out" => "devise/sessions#destroy", :as => :destroy_user_session
  end
  
  resources :users, :only => :show
  
  get "/aash" => "aash#show"
  
  get "/freeplay" => "freeplay#show"
  
  get "/logger" => "logger#logthis"
  
  post "/getdata"=> "logger#getdata"
  
  get "/users/password/check" => "home#checkUser"
  get "/crossdomain.xml" => "logger#crossdomain"
  get "/showgame" => "logger#game"
  get "bull/freeplay" => "logger#freeplay"
  
  get "/product" => "home#showmathfact"
  get "/team" => "home#team"
  
  get "/details" => "logger#showdetails"
  
end
