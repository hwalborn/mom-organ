class SessionsController < ApplicationController
  def new
    @account = Account.new
  end

  def create
    account = Account.find_by(username: session_params[:username])
    if(account && account.authenticate(session_params[:password]))
      session[:user_id] = account.id
      flash[:notice] = "Welcome, mom!"
      redirect_to musics_path
    else
      flash[:error] = "Only my mom can login"
      redirect_to musics_path
    end
  end

  def destroy
    session.clear
    redirect_to musics_path
  end

  private
  def session_params
    params.require(:account).permit(:username, :password)
  end
end
