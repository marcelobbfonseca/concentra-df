class HomeController < ApplicationController
   
    def index
        if !user_signed_in?
          redirect_to new_user_session_path # path: users/sign_in controller: devise/sessions#new 
        else
        	@user = current_user #acesso @user.name
        end

    end

end