class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password]) #validacao
      # Log the user in and redirect to the user's show page.
      log_in user
      redirect_to login_path
    else
      flash.now[:danger] = 'Invalid email/password combination' # holy guacamolei! danger nao vai rolar pq nao tem bootstrap :/
      render 'new'
    end
  end
  

  def destroy
    log_out
    redirect_to root_url    
  end
end
