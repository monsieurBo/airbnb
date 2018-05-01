class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  def allowed?(action:, user:)
  	case action
  	when "listing_destroy"
  		if (user != current_user.id || !current_user.superadmin?) || current_user.moderator?
  			flash[:notice] = "Sorry. You are not allowed to perform this action."
        redirect_to listings_path, notice: "Sorry. You do not have the permission to delete a property."
  			return false
      else
      	return true
      end
    when "listing_edit"
  		if (user != current_user.id || current_user.superadmin?) || current_user.moderator?
  			flash[:notice] = "Sorry. You are not allowed to perform this action."
        redirect_to listings_path, notice: "Sorry. You do not have the permission to edit a property."
  			return false
      else
      	return true
      end
    when "listing_verify"
  		if current_user.customer? || current_user.superadmin?
  			flash[:notice] = "Sorry. You are not allowed to perform this action."
        redirect_to listings_path, notice: "Sorry. You do not have the permission to verify a property."
  			return false
      else
      	return true
      end
    when "listing_create"
  		if current_user.superadmin? || current_user.moderator?
  			flash[:notice] = "Sorry. You are not allowed to perform this action."
        redirect_to listings_path, notice: "Sorry. You do not have the permission to create a property."
  			return false
      else
      	return true
      end

  	end
  end
end
