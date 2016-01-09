# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController

  def update

  	#binding.pry

  	$validation_bool = true

    super

    if ($validation_bool)

	    if (params[:user][:parent_email].to_s != current_user.parent_email.to_s || params[:user][:name].to_s != current_user.name)

	    	$new_user_name = current_user.name
	    	$new_parent_email = params[:user][:parent_email]
	    	
	  		UserMailer.sendkey(current_user, $new_user_name, $new_parent_email).deliver
	  	end
	end

  end
end 