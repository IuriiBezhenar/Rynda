class CompaniesController < ApplicationController

  before_filter { |controller| authenticate;   # check session timeout
                               @protected_class  = controller.class.name;
                               @protected_action = controller.action_name }

  before_filter :check_privileges!,
                :only => [:index, :create, :update, :destroy]


  before_filter :locate_object, :only => [:show, :update]
  
  def new
    @title   = Const::STR_TITLE_NEW_COMPANY
    @company = Company.new
  end

  def index
    @companies = Company.all.paginate(:page => params[:page])
  end

  def show
    @title = @company.name
  end

  def create
    @company = Company.new(params[:company])

    if @company.save
      flash[:success] = Const::STR_MSG_SUCCESS_COMPANY_CREATION
      redirect_to @company
    else
      @title = Const::STR_TITLE_NEW_COMPANY
      render :new
    end
  end

  def edit
    @title   = Const::STR_TITLE_EDIT_COMPANY
    @company = Company.find(params[:id])
  end

  def update
    if @company.update_attributes(params[:company])
      flash[:success] = Const::STR_MSG_SUCCESS_COMPANY_UPDATE
      redirect_to @company
    else
      @title = Const::STR_TITLE_EDIT_COMPANY
      render :edit
    end
  end

  def switch_current
    @available_companies = current_user.available_companies(current_company)
  end

  def make_current
    if params[Const::STR_FIELD_NAME_COMPANY_ID]
      switch_current_company(Company.find_by_id(params[Const::STR_FIELD_NAME_COMPANY_ID]))
    end
    redirect_to root_path
  end

  def destroy
    @company = Company.find(params[:id])
    if @company.destroyable?
      @company.destroy
      flash[:success] = Const::STR_MSG_SUCCESS_COMPANY_DELETION
      redirect_to companies_path
    else
      flash[:error] = Const::STR_MSG_FAILURE_COMPANY_DELETION
      redirect_to company_path
    end
  end

  private

    def locate_object
      @company = Company.find(params[:id])
      redirect_to root_path unless @company
    end

end
