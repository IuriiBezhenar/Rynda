class SessionsController < ApplicationController

  def new
    @title = Const::STR_TITLE_SIGN_IN
  end

  def create
    user = User.authenticate(params[:session][:login], params[:session][:password])
    if user.nil?
      flash.now[:error] = Const::STR_MSG_INVALID_SIGN_IN_PARAMS
      @title = Const::STR_TITLE_SIGN_IN
      render :new
    else
      sign_in user
      redirect_back_or root_path   # user <- t'was earlier
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
