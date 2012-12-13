class UsersController < ApplicationController

  before_filter { |controller| ##authenticate;   # check session timeout
                               @protected_class  = controller.class.name;
                               @protected_action = controller.action_name }

  before_filter :check_privileges!,
                :only => [:index, :update, :destroy, :process_roles]
  
  before_filter :locate_object,      :only => [:show, :edit, :update, :destroy,
                                               :manage_roles, :process_roles]
  before_filter :authenticate,       :except => [:show, :new, :create]
  before_filter :correct_user,       :only => [:edit, :update]
  before_filter :admin_user,         :only => [:destroy, :manage_roles]
  before_filter :non_signed_in_user, :only => [:new, :create]

  def new
    @user  = User.new
    @title = Const::STR_TITLE_SIGN_UP
  end

  def index
    @title = Const::STR_TITLE_ALL_USERS
    @users = User.paginate(:page => params[:page])

    # adding export to Excel
    respond_to do |format|
      format.html # index.html.erb
      format.xls
      format.xml  { render :xml => @users }
    end
  end

  def show
    @title = @user.login
  end

  def create
    @user = User.new(params[:user])
    @user.status_id = Const::ID_USER_STATUS_ACTIVE  # stub
    if @user.save
      sign_in @user
      flash[:success] = Const::STR_MSG_WELCOME_ABOARD
      redirect_to @user
    else
      @title = Const::STR_TITLE_SIGN_UP
      render :new
    end
  end

  def edit
    @title = Const::STR_TITLE_EDIT_USER
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = Const::STR_MSG_SUCCESS_USER_UPDATE
      redirect_to @user
    else
      @title = Const::STR_TITLE_EDIT_USER
      render :edit
    end
  end

  def destroy
    if @user.destroyable?
      @user.destroy
      flash[:success] = Const::STR_MSG_SUCCESS_USER_DELETION
    else
      flash[:error] = Const::STR_MSG_ADMIN_DESTROY_PROTECTION
    end
    redirect_to users_path
  end

  def process_roles
    msg = ''
    if params[:granted]
      params[:granted].each {|role_id| @user.grant_role!(current_user, role_id, current_company.id)}
      msg += Const::STR_MSG_GRANTED_ROLE_COUNT + params[:granted].count.to_s
    end
    if params[:revoked]
      params[:revoked].each {|role_id| @user.revoke_role!(current_user, role_id, current_company.id)}
      msg += '; ' if msg.size > 0
      msg += Const::STR_MSG_REVOKED_ROLE_COUNT + params[:revoked].count.to_s
    end
    flash[:success] = msg if msg > ''
    redirect_to manage_roles_user_path
  end

  private

    def locate_object
      @user = User.find(params[:id])
    end

    def correct_user
      # locate_object
      redirect_to(root_path) unless current_user?(@user)
    end

    def non_signed_in_user
      redirect_to(root_path) if signed_in?
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end