class ServiceRequestsController < ApplicationController

  # respond_to :html, :js    <= no need since jQuery use

  before_filter { |controller| authenticate;   # check session timeout
                               @protected_class  = controller.class.name;
                               @protected_action = controller.action_name }

  before_filter :check_privileges!,
                :only => [:index, :create, :update, :destroy, :show_status_track,
                          :make_sent, :make_received, :make_approved,
                          :make_returned]

  before_filter :locate_object,
                :only => [:show, :edit, :update, :make_sent, :show_status_track,
                          :select_prfm_community, :make_received,
                          :make_committed, :approving, :make_approved,
                          :returning, :make_returned, :destroy]

  def new
    @title           = Const::STR_TITLE_NEW_SERV_REQ
    @service_request = ServiceRequest.new
  end

  def index
    @selector = Selector.new
    # defaults
    @selector.processable = 1
    @selector.owned_only  = 1
  end

  def show_list
    @title  = "Request list"
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
      @service_requests = ServiceRequest.
                            selected_list(current_user.id, current_company.id, @selector).
                            paginate(:page => params[:page])
    end

    respond_to do |format|
      format.html { render :index }
      format.js
    end
  end

  def show
    @title = "Service request # #{@service_request.id}"
  end

  def create
    @service_request = ServiceRequest.new(params[:service_request])
    @service_request.requester = current_user
    @service_request.company   = current_company

    if @service_request.save
      flash[:success] = Const::STR_MSG_SUCCESS_SERV_REQ_CREATION
      redirect_to @service_request
    else
      # TODO - test on failure
      @title = Const::STR_TITLE_NEW_SERV_REQ
      render :new
    end
  end

  def edit
    @title = Const::STR_TITLE_EDIT_SERV_REQ
  end

  def update
    @service_request.moderator = current_user
    if @service_request.update_attributes(params[:service_request])
      flash[:success] = Const::STR_MSG_SUCCESS_SERV_REQ_UPDATE
      redirect_to @service_request
    else
      @title = Const::STR_TITLE_EDIT_SERV_REQ
      render :edit
    end
  end

  def make_sent
    if @service_request.get_sent?(current_user)
      flash[:success] = Const::STR_MSG_SUCCESS_SERV_REQ_SENDING
      redirect_to service_requests_path
    else
      flash[:error] = Const::STR_MSG_FAILURE_SERV_REQ_SENDING
      redirect_to @service_request
    end
  end

  def select_prfm_community
    if @service_request.can_be_received?
      @communities = current_company.communities
      # set status field accordingly
      @service_request.status_id = Const::ID_SERVICE_REQ_STATUS_RECEIVED
    else
      redirect_to @service_request,
                  :notice => Const::STR_MSG_UNRECEIVABLE_SERV_REQ
    end
  end

  def make_received
    pc_id = params[:prfm_community_id]
    if @service_request.get_received?(current_user, pc_id)
      notify_requester(@service_request, "Request received")
      flash[:success] = Const::STR_MSG_SUCCESS_SERV_REQ_RECEVING
      redirect_to service_requests_path
    else
      flash[:error] = Const::STR_MSG_FAILURE_SERV_REQ_RECEVING
      redirect_to @service_request
    end
  end

  def approving
    if @service_request.can_be_approved?
      # set status field accordingly
      @service_request.status_id = Const::ID_SERVICE_REQ_STATUS_APPROVED
    else
      redirect_to @service_request,
                  :notice => Const::STR_MSG_UNAPPROVABLE_SERV_REQ
    end
  end

  def make_approved
    info = params[:callback_info]
    if @service_request.get_approved?(current_user, info)
      notify_performer(@service_request, "Request approved", info)
      flash[:success] = Const::STR_MSG_SUCCESS_SERV_REQ_APPROVING
      redirect_to service_requests_path
    else
      flash[:error] = Const::STR_MSG_FAILURE_SERV_REQ_APPROVING
      redirect_to @service_request
    end
  end

  def returning
    if @service_request.can_be_returned?
      # set status field accordingly
      @service_request.status_id = Const::ID_SERVICE_REQ_STATUS_RETURNED
    else
      redirect_to @service_request,
                  :notice => Const::STR_MSG_UNRETURNABLE_SERV_REQ
    end
  end
  
  def make_returned
    info = params[:callback_info]
    if @service_request.get_returned?(current_user, info)
      notify_performer(service_request, "Request returned", info)
      flash[:success] = Const::STR_MSG_SUCCESS_SERV_REQ_RETURNING
      redirect_to service_requests_path
    else
      flash[:error] = Const::STR_MSG_FAILURE_SERV_REQ_RETURNING
      redirect_to @service_request
    end
  end

  def destroy
    if @service_request.destroyable?
      @service_request.destroy
      flash[:success] = Const::STR_MSG_SUCCESS_SERV_REQ_DELETION
    else
      flash[:error] = Const::STR_MSG_FAILURE_SERV_REQ_DELETION
    end
    redirect_to service_request_path
  end

  private

    def locate_object
      @service_request = ServiceRequest.find(params[:id])
      redirect_to root_path unless @service_request
    end

    def notify_requester(service_request, event_descr)
      UserMailer.notify(service_request.requester, event_descr,
                        service_request.table_view)
    end

    def notify_performer(service_request, event_descr, callback_info)
      service_request.service_operations.each do |so|
        if so.performer
          UserMailer.notify(so.performer, event_descr,
                            so.table_view + "\n-------\n#{callback_info}")
        end
      end
    end

end
