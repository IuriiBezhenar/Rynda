class ServiceOperationsController < ApplicationController

  before_filter { |controller| authenticate;   # check session timeout
                               @protected_class  = controller.class.name;
                               @protected_action = controller.action_name }

  before_filter :check_privileges!,
                :only => [:index, :create, :update, :destroy, :show_status_track,
                          :make_planned, :make_assigned, :make_activated,
                          :make_canceled, :make_committed]

  before_filter :locate_object,
                :only => [:show, :edit, :update, :show_status_track,
                          :make_planned, :make_assigned,
                          :select_performer, :activation, :make_activated,
                          :cancellation, :make_canceled, :committing,
                          :destroy]

  def new
    @title             = Const::STR_TITLE_NEW_SERV_OPER
    @service_operation = ServiceOperation.new
    @communities       = current_company.communities
  end

  def index
    @selector = Selector.new
    # defaults
    @selector.processable = 1
    @selector.owned_only  = 1
  end

  def show_list
    @title  = "Operation list"
    # because of untyped fields the statement (new(params[:selector])) is not applicable
    @selector = Selector.new
    @selector.processable = params[:selector][:processable].to_i
    @selector.archive     = params[:selector][:archive].to_i
    @selector.owned_only  = params[:selector][:owned_only].to_i
    @selector.date_from   = params[:selector][:date_from].to_date
    @selector.date_to     = params[:selector][:date_to].to_date

    if ((@selector.processable == 0) && (@selector.archive == 0)) ||
       ((@selector.archive == 1) && (!@selector.date_from)) ||
       (@selector.date_to && (@selector.date_to < @selector.date_from))
      # clearing value of date_to if there's a logical inconsistency
      @selector.date_to = (@selector.date_to && (@selector.date_to < @selector.date_from) ?
                           nil : @selector.date_to)
      @wrong_selector = true   # to interprete problem
    else
      @service_operations = ServiceOperation.
                              selected_list(current_user.id, current_company.id, @selector).
                              paginate(:page => params[:page])
    end

    respond_to do |format|
      format.html { render :index }
      format.js
    end
  end

  def show
    @title = "Service operation # #{@service_operation.id}"
  end

  def create
    @service_operation = ServiceOperation.new(params[:service_operation])
    @service_operation.company   = current_company
    @service_operation.moderator = current_user

    if @service_operation.save
      flash[:success] = Const::STR_MSG_SUCCESS_SERV_OPER_CREATION
      redirect_to @service_operation
    else
      @title = Const::STR_TITLE_NEW_SERV_OPER
      render :new
    end
  end

  def edit
    @title = Const::STR_TITLE_EDIT_SERV_OPER
    @communities = current_company.communities
  end

  def update
    @service_operation.moderator = current_user
    if @service_operation.update_attributes(params[:service_operation])
      flash[:success] = Const::STR_MSG_SUCCESS_SERV_OPER_UPDATE
      redirect_to @service_operation
    else
      @title = Const::STR_TITLE_EDIT_SERV_OPER
      render :edit
    end
  end

  def make_planned
    if @service_operation.get_planned?(current_user)
      notify_requester(@service_operation)
      flash[:success] = Const::STR_MSG_SUCCESS_SERV_OPER_PLANNING
      redirect_to service_operations_path
    else
      flash[:error] = Const::STR_MSG_FAILURE_SERV_OPER_PLANNING
      redirect_to @service_operation
    end
  end

  def select_performer
    flag = false
    info = ''
    if @service_operation.can_be_assigned?
      @performers = User.available_performers(current_company,
                                              @service_operation.prfm_community_id)
      if @performers && (@performers.count > 0)
        # set status field accordingly
        @service_operation.status_id = Const::ID_SERVICE_OPER_STATUS_ASSIGNED
        flag = true
      else
        info = Const::STR_MSG_NO_OPER_PERFORMERS_EXIST
      end
    end
    redirect_to @service_operation,
                :notice => Const::STR_MSG_UNASSIGNABLE_SERV_OPER + info unless flag
  end

  def make_assigned
    performer = User.find_by_id(params[:service_operation][:performer_id])
    if @service_operation.get_assigned?(current_user, performer,
                                        params[:service_operation][:descr])
      flash[:success] = Const::STR_MSG_SUCCESS_SERV_OPER_ASSIGNING

      # event messenger
      notify_requester(@service_operation)
      notify_performer(@service_operation)
      redirect_to service_operations_path
    else
      redirect_to @service_operation,
                  :notice => Const::STR_MSG_FAILURE_SERV_OPER_ASSIGNING
    end
  end

  def activation
    if @service_operation.can_be_activated?
      # set status field accordingly
      @service_operation.status_id = Const::ID_SERVICE_OPER_STATUS_ACTIVATED
    else
      redirect_to @service_operation, :notice => Const::STR_MSG_INACTIVATED_SERV_OPER
    end
  end

  def make_activated
    if @service_operation.get_activated?(current_user,
                                         params[:service_operation][:report])
      notify_requester(@service_operation)
      notify_performer(@service_operation)
      flash[:success] = Const::STR_MSG_SUCCESS_SERV_OPER_ACTIVATION
      redirect_to service_operations_path
    else
      flash[:error] = Const::STR_MSG_FAILURE_SERV_OPER_ACTIVATION
      redirect_to @service_operation
    end
  end

  def cancellation
    if @service_operation.can_be_canceled?
      # set status field accordingly
      @service_operation.status_id = Const::ID_SERVICE_OPER_STATUS_CANCELED
    else
      redirect_to @service_operation, :notice => Const::STR_MSG_NON_CANCELED_SERV_OPER
    end
  end

  def make_canceled
    if @service_operation.get_canceled?(current_user,
                                        params[:service_operation][:report])
      notify_requester(@service_operation)
      notify_performer(@service_operation)
      flash[:success] = Const::STR_MSG_SUCCESS_SERV_OPER_CANCEL
      redirect_to service_operations_path
    else
      flash[:error] = Const::STR_MSG_FAILURE_SERV_OPER_CANCEL
      redirect_to @service_operation
    end
  end

  def committing
    if @service_operation.can_be_committed?
      # set status field accordingly
      @service_operation.status_id = Const::ID_SERVICE_OPER_STATUS_COMMITTED
    else
      redirect_to @service_operation, :notice =>  Const::STR_MSG_UNCOMMITTED_SERV_OPER
    end
  end

  def make_committed
    if @service_operation.get_committed?(current_user,
                                         params[:service_operation][:report])
      notify_requester(@service_operation)
      flash[:success] = Const::STR_MSG_SUCCESS_SERV_OPER_COMMITTING
      redirect_to service_operations_path
    else
      flash[:error] = Const::STR_MSG_FAILURE_SERV_OPER_COMMITTING
      redirect_to @service_operation
    end
  end

  def destroy
    if @service_operation.destroyable?
      @service_operation.destroy
      flash[:success] = Const::STR_MSG_SUCCESS_SERV_OPER_DELETION
    else
      flash[:error] = Const::STR_MSG_FAILURE_SERV_OPER_DELETION
    end
    redirect_to service_operation_path
  end

  private

    def locate_object
      @service_operation = ServiceOperation.find(params[:id])
      redirect_to root_path unless @service_operation
    end

    # send message to requester if he exists
    def notify_requester(service_operation)
      requester = service_operation.service_request ?
                    service_operation.service_request.requester : nil
      if requester
        UserMailer.notify(requester,
                          Const::STR_LABEL_SERVICE_OPERATION,
                          service_operation.table_view)
      end
    end

    def notify_performer(service_operation)
      if service_operation.performer
        UserMailer.notify(service_operation.performer,
                          Const::STR_LABEL_SERVICE_OPERATION,
                          service_operation.table_view)
      end
    end

end
