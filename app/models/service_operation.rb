class ServiceOperation < ActiveRecord::Base

  belongs_to :type, :class_name => Const::MODEL_CLASS_NAME_SYSTYPE
  belongs_to :status, :class_name => Const::MODEL_CLASS_NAME_SYSTYPE
  belongs_to :moderator, :class_name => Const::MODEL_CLASS_NAME_USER
  belongs_to :performer, :class_name => Const::MODEL_CLASS_NAME_USER
  belongs_to :inspector, :class_name => Const::MODEL_CLASS_NAME_USER
  belongs_to :company
  belongs_to :service_request
  belongs_to :prfm_community, :class_name => Const::MODEL_CLASS_NAME_COMMUNITY

  validates :type_id, :presence => true
  validates :status_id, :presence => true
  validates :status_date, :presence => true
  validates :company_id, :presence => true
  validates :moderator_id, :presence => true

  before_validation :assign_defaults
  before_save :before_save_handler
  after_save  :after_save_handler

  #============================================================
  def self.selected_list(user_id, company_id, selector)
    self.internal_selected_list(user_id, company_id, selector)
  end
  #============================================================
  def status_track
    StatusTrack.where(:object_type_id => Const::ID_OBJECT_TYPE_SERVICE_OPERATION,
                      :object_id => id).order(Const::STR_FIELD_NAME_CREATED_AT +
                                              Const::STR_VALUE_SQL_DESC)
  end
  #============================================================
  def table_view
    "id: #{id}\n" +
    "company: #{company.name}\n" +
    "type: #{type.name}\n" +
    "status: #{status.name}\n" +
    "created at: #{created_at}\n" +
    (service_request ? "request info: #{service_request.request_info}\n" : "") +
    (performer ? "performer: #{performer.name}\n" : "") +
    (descr ? "description: #{descr}\n" : "") +
    (report ? "report: #{report}" : "")
  end
  #============================================================
  def destroyable?
    status_id == Const::ID_SERVICE_OPER_STATUS_DRAFT
  end
  #============================================================
  def editable?
    status_id == Const::ID_SERVICE_OPER_STATUS_DRAFT
  end
  #============================================================
  def can_be_planned?
    (status_id == Const::ID_SERVICE_OPER_STATUS_DRAFT) &&
    (service_request_id || (descr.length > 0))
  end
  #============================================================
  def can_be_assigned?
    status_id == Const::ID_SERVICE_OPER_STATUS_PLANNED
  end
  #============================================================
  def can_be_activated?
    status_id == Const::ID_SERVICE_OPER_STATUS_ASSIGNED
  end
  #============================================================
  def can_be_committed?
    (status_id == Const::ID_SERVICE_OPER_STATUS_ASSIGNED) ||
    (status_id == Const::ID_SERVICE_OPER_STATUS_ACTIVATED)
  end
  #============================================================
  def can_be_canceled?
    (status_id == Const::ID_SERVICE_OPER_STATUS_PLANNED  ) ||
    (status_id == Const::ID_SERVICE_OPER_STATUS_ASSIGNED ) ||
    (status_id == Const::ID_SERVICE_OPER_STATUS_ACTIVATED)
  end
  #============================================================
  def can_be_accepted?
    status_id == Const::ID_SERVICE_OPER_STATUS_COMMITTED
  end
  #============================================================
  def can_be_rejected?
    status_id == Const::ID_SERVICE_OPER_STATUS_COMMITTED
  end
  #============================================================
  def assignor
    st = StatusTrack.where(:object_type_id => Const::ID_OBJECT_TYPE_SERVICE_OPERATION,
                           :object_id => id,
                           :status_id => Const::ID_SERVICE_OPER_STATUS_ASSIGNED).first
    st.moderator if st
  end
  #============================================================
  def get_planned?(user)
    result = can_be_planned?
    if result
      result = false
      # test if assigned community comprise at least one performer
      performers = User.available_performers(company_id, prfm_community_id)
      if performers && (performers.count > 0)
        result = service_request.nil?
        if !result
          result = service_request.get_received_with_operation?(user, self)
        end
        if result
          internal_save!(user.id, Const::ID_SERVICE_OPER_STATUS_PLANNED)
        end
      end
    end
    result
  end
  #============================================================
  # called by <service_request.internal_get_received?>
  def self.create_on_request!(serv_request, prfm_community_id)
    oper = ServiceOperation.new(
             :type_id => Const::HASH_REQUEST_OPERATION_TYPE[serv_request.type_id],
             :service_request_id => serv_request.id,
             :company_id         => serv_request.company_id,
             :moderator_id       => serv_request.moderator_id)
    oper.save!
    # then turn to planned status immediately
    oper.status_id         = Const::ID_SERVICE_OPER_STATUS_PLANNED
    oper.prfm_community_id = prfm_community_id
    oper.save!
  end
  #============================================================
  def get_assigned?(assignor, assignee, description)
    if can_be_assigned? && assignor && assignee &&
       (service_request.nil? || service_request.get_assigned?(assignor))
      self.performer_id = assignee.id
      self.descr        = description
      internal_save!(assignor.id, Const::ID_SERVICE_OPER_STATUS_ASSIGNED)
    else
      false
    end
  end
  #============================================================
  def get_activated?(user, report)
    if can_be_activated? &&
       # switch linked service request to activated status:
       (service_request.nil? || service_request.get_activated?(user))
      internal_save!(user.id, Const::ID_SERVICE_OPER_STATUS_ACTIVATED, report)
    else
      false
    end
  end
  #============================================================
  def get_committed?(user, report)
    if can_be_committed? &&
       # switch linked service request to processed status:
       (service_request.nil? || service_request.get_processed?(user))
      internal_save!(user.id, Const::ID_SERVICE_OPER_STATUS_COMMITTED, report)
    else
      false
    end
  end
  #============================================================
  def get_canceled?(user, report)
    if can_be_canceled? &&
       # switch linked service request to canceled status as well:
       (service_request.nil? || service_request.get_canceled?(user))
      internal_save!(user.id, Const::ID_SERVICE_OPER_STATUS_CANCELED, report)
    else
      false
    end
  end
  #============================================================
  def get_accepted?(user, callback_info)
    can_be_accepted? ?
      accept_or_reject!(user, Const::ID_SERVICE_OPER_STATUS_ACCEPTED, callback_info) :
      false
  end
  #============================================================
  def get_rejected?(user, callback_info)
    can_be_rejected? ? 
       accept_or_reject!(user, Const::ID_SERVICE_OPER_STATUS_REJECTED, callback_info) :
       false
  end
  #============================================================


  private

    #==========================================================
    # substitution with default values
    def assign_defaults
      if new_record?
        self.status_id   = Const::ID_SERVICE_OPER_STATUS_DRAFT unless self.status_id
        self.status_date = Time.now
      end
    end
    #==========================================================
    def before_save_handler
      # change operation type with appropriate value in accordance to the request
      if new_record? || type_id_changed? || service_request_id_changed?
        if service_request
          self.type_id = Const::HASH_REQUEST_OPERATION_TYPE[service_request.type_id]
        end
      end
      self.status_date = Time.now if status_id_changed?
    end
    #==========================================================
    def after_save_handler
      if status_id_changed?
        StatusTrack.create_track!(Const::ID_OBJECT_TYPE_SERVICE_OPERATION,
                                  id, moderator_id, status_id)
      end
    end
    #==========================================================
    def accept_or_reject!(user, new_status_id, callback_info)
      self.moderator_id = user.id
      self.status_id    = new_status_id
      self.inspector_id = user.id
      self.remark       = callback_info
      self.save!
    end

    #==========================================================
    def internal_save!(moderator_id, status_id, report = nil)
      self.moderator_id = moderator_id
      self.status_id    = status_id
      self.report       = report if report
      self.save!
    end

    #==========================================================
    def self.internal_selected_list(user_id, company_id, selector)
      status_list = []
      if (selector.processable == 1) && (selector.archive != 1)
        status_list = [Const::ID_SERVICE_OPER_STATUS_DRAFT,
                       Const::ID_SERVICE_OPER_STATUS_PLANNED,
                       Const::ID_SERVICE_OPER_STATUS_ASSIGNED,
                       Const::ID_SERVICE_OPER_STATUS_ACTIVATED,
                       Const::ID_SERVICE_OPER_STATUS_COMMITTED]

      else
        if (selector.processable != 1) && (selector.archive == 1)
          status_list = [Const::ID_SERVICE_OPER_STATUS_ACCEPTED,
                         Const::ID_SERVICE_OPER_STATUS_REJECTED,
                         Const::ID_SERVICE_OPER_STATUS_CANCELED]
        end
      end

      date1 = selector.date_from
      date2 = date1 ? ((selector.date_to ? selector.date_to : Date.today) + 1) : nil

      condit = "#{Const::STR_FIELD_NAME_COMPANY_ID} = :company_id"
      condit += " and #{Const::STR_FIELD_NAME_STATUS_ID} in (:status_list)"  if (status_list.count > 0)
      if selector.owned_only == 1
        condit += " and (#{Const::STR_FIELD_NAME_MODERATOR_ID} = :moderator_id" +
                  " or #{Const::STR_FIELD_NAME_PERFORMER_ID} = :performer_id" +
                  " or #{Const::STR_FIELD_NAME_INSPECTOR_ID} = :inspector_id)"
      end
      condit += " and #{Const::STR_FIELD_NAME_STATUS_DATE} between :date_from and :date_to" if (date1)

      ServiceOperation.where(condit, {:company_id   => company_id,
                                      :status_list  => status_list,
                                      :moderator_id => user_id,
                                      :performer_id => user_id,
                                      :inspector_id => user_id,
                                      :date_from    => date1,
                                      :date_to      => date2}).order(:id)

    end
    #==========================================================
end
