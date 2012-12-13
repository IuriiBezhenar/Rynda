class BusinessUnitsController < ApplicationController

  before_filter { |controller| authenticate;   # check session timeout
                               @protected_class  = controller.class.name;
                               @protected_action = controller.action_name }
                             
  before_filter :check_privileges!,
                :only => [:index, :create, :update, :destroy]
              
  before_filter :locate_object, :only => [:show, :update, :destroy]

  def new
    @title         = Const::STR_TITLE_NEW_BUSINESS_UNIT
    @business_unit = BusinessUnit.new
    @company       = Company.find_by_id(params[:company_id])
  end

  def show
    @title = @business_unit.name
  end

  def create
    @business_unit = BusinessUnit.new(params[:business_unit])
    @business_unit.company = Company.find_by_id(params[:company_id])

    if @business_unit.save
      flash[:success] = Const::STR_MSG_SUCCESS_BSNS_UNIT_CREATION
      redirect_to @business_unit
    else
      @title = Const::STR_TITLE_NEW_BUSINESS_UNIT
      render :new
    end
  end

  def edit
    @title         = Const::STR_TITLE_EDIT_BUSINESS_UNIT
    @business_unit = BusinessUnit.find(params[:id])
  end

  def update
    if @business_unit.update_attributes(params[:business_unit])
      flash[:success] = Const::STR_MSG_SUCCESS_BSNS_UNIT_UPDATE
      redirect_to @business_unit
    else
      @title = Const::STR_TITLE_EDIT_BUSINESS_UNIT
      render :edit
    end
  end

  def destroy
    if @business_unit.destroyable?
      @business_unit.destroy
      flash[:success] = Const::STR_MSG_SUCCESS_BSNS_UNIT_DELETION
      redirect_to business_units_path
    else
      flash[:error] = Const::STR_MSG_FAILURE_BSNS_UNIT_DELETION
      redirect_to business_unit_path
    end
  end

  private

    def locate_object
      @business_unit = BusinessUnit.find(params[:id])
      redirect_to root_path unless @business_unit
    end

end
