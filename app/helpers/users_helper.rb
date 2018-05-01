module UsersHelper

  def profile_check
  	if @user.first_name? || @user.last_name? || @user.phone? || @user.country? || @user.birthdate?
  		return true
  	else
  		return false
  	end
  end
  
end
