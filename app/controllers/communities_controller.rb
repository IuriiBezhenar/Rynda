class CommunitiesController < ApplicationController

  before_filter { |controller| authenticate;   # check session timeout
                               @protected_class  = controller.class.name;
                               @protected_action = controller.action_name }

  before_filter :check_privileges!,
                :only => [:index, :create, :update, :destroy,
                          :process_privileges]

  before_filter :locate_object, :only => [:show, :edit, :update,
                                          :destroy, :manage_members,
                                          :process_members]

  def index
    @title = Const::STR_TITLE_ALL_COMMUNITIES
    @company = Company.find_by_id(params[:company_id])
    if @company
      @communities = @company.communities.paginate(:page => params[:page])

      # export to Excel
      #respond_to do |format|
      #  format.html  # index.html.erb
      #  format.xls
      #  format.xml  { render :xml => @communities }
      #end
    else
      redirect_to root_path
    end
  end

  def show
    @title = Const::STR_TITLE_SHOW_COMMUNITY
  end

  def new
    @community = Community.new
    @community.company = Company.find_by_id(params[:company_id])
    @title = Const::STR_TITLE_NEW_COMMUNITY
  end

  def create
    @community = Community.new(params[:community])
    @community.company_id = params[:company_id]
    if @community.save
      flash[:success] = Const::STR_MSG_SUCCESS_COMMUNITY_CREATION
      redirect_to @community
    else
      @title = Const::STR_TITLE_NEW_COMMUNITY
      render :new
    end
  end

  def edit
    @title = Const::STR_TITLE_EDIT_COMMUNITY
  end

  def update
    if @community.update_attributes(params[:community])
      flash[:success] = Const::STR_MSG_SUCCESS_COMMUNITY_UPDATE
      redirect_to @community
    else
      @title = Const::STR_TITLE_EDIT_COMMUNITY
      render :edit
    end
  end

  def destroy
    if @community.destroyable?
      @community.destroy
      flash[:success] = Const::STR_MSG_SUCCESS_COMMUNITY_DELETION
    else
      flash[:error] = Const::STR_MSG_FAILURE_COMMUNITY_DELETION
    end
    redirect_to communities_path
  end

  def manage_members
    @members = @community.users
  end

  def process_members
    msg = ''
    if params[:included]
      params[:included].each {|e| @community.include_member!(current_user, e)}
      msg += Const::STR_MSG_INCLUDED_MEMBER_COUNT + params[:included].count.to_s
    end
    if params[:excluded]
      params[:excluded].each {|e| @community.exclude_member!(current_user, e)}
      msg += '; ' if msg.size > 0
      msg += Const::STR_MSG_EXCLUDED_MEMBER_COUNT + params[:excluded].count.to_s
    end
    flash[:success] = msg if msg > ''
    redirect_to manage_members_community_path
  end

  private

    def locate_object
      @community = Community.find(params[:id])
      redirect_to root_path unless @community
    end

end
