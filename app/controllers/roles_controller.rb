class RolesController < ApplicationController

  before_filter { |controller| authenticate;   # check session timeout
                               @protected_class  = controller.class.name;
                               @protected_action = controller.action_name }

  before_filter :check_privileges!,
                :only => [:index, :create, :update, :destroy,
                          :process_privileges]

  before_filter :locate_object, :only => [:show, :edit, :update,
                                          :destroy, :manage_privileges,
                                          :process_privileges]

  def new
    @role  = Role.new
    @title = Const::STR_TITLE_NEW_ROLE
  end

  def index
    @title = Const::STR_TITLE_ALL_ROLES
    @roles = Role.paginate(:page => params[:page])

    # export to Excel
    #respond_to do |format|
    #  format.html  # index.html.erb
    #  format.xls
    #  format.xml  { render :xml => @roles }
    #end
  end

  def show
    @title = Const::STR_TITLE_SHOW_ROLE
  end

  def create
    @role = Role.new(params[:role])
    if @role.save
      flash[:success] = Const::STR_MSG_SUCCESS_ROLE_CREATION
      redirect_to @role
    else
      @title = Const::STR_TITLE_NEW_ROLE
      render :new
    end
  end

  def edit
    @title = Const::STR_TITLE_EDIT_ROLE
  end

  def update
    if @role.update_attributes(params[:role])
      flash[:success] = Const::STR_MSG_SUCCESS_ROLE_UPDATE
      redirect_to @role
    else
      @title = Const::STR_TITLE_EDIT_ROLE
      render :edit
    end
  end

  def destroy
    if @role.destroyable?
      @role.destroy
      flash[:success] = Const::STR_MSG_SUCCESS_ROLE_DELETION
    else
      flash[:error] = Const::STR_MSG_FAILURE_ROLE_DELETION
    end
    redirect_to roles_path
  end

  def manage_privileges
    @privileges = @role.granted_privileges
  end

  def process_privileges
    msg = ''
    if params[:granted]
      params[:granted].each {|e| @role.grant_privilege!(current_user, e)}
      msg += Const::STR_MSG_GRANTED_PRIVILEGE_COUNT + params[:granted].count.to_s
    end
    if params[:revoked]
      params[:revoked].each {|e| @role.revoke_privilege!(current_user, e)}
      msg += '; ' if msg.size > 0
      msg += Const::STR_MSG_REVOKED_PRIVILEGE_COUNT + params[:revoked].count.to_s
    end
    flash[:success] = msg if msg > ''
    redirect_to manage_privileges_role_path
  end

  private

    def locate_object
      @role = Role.find(params[:id])
      redirect_to root_path unless @role
    end

end
