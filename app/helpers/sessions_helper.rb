module SessionsHelper

  suppress_warnings { load 'const.rb' }  # preventing "already initialized constant" in log

  #---------------------------------------------------------------
  def sign_in(user)
    # cookies.permanent.signed[:remember_token] = [user.id, user.salt]  -- expires in 20 years
    cookies.signed[:rynda_remember_token] =
      { :value => [user.id, user.salt],
        :expires => Time.now + Const::INT_VALUE_SESSION_TIME_IN_SEC } # expires in 2 hours
    self.current_user = user
    store_companies    # retrieve companies which can be accessed from current account and set current company
    store_privileges   # retrieve privileges list for current company and save it in session object
  end

  #---------------------------------------------------------------
  def current_user=(user)
    @current_user = user
  end

  #---------------------------------------------------------------
  def current_user
    @current_user ||= user_from_remember_token  # TODO - eliminate db-query any time the user needed
  end

  #---------------------------------------------------------------
  def signed_in?
    !current_user.nil?
  end

  #---------------------------------------------------------------
  def sign_out
    cookies.delete(:rynda_remember_token)
    self.current_user = nil
  end

  #---------------------------------------------------------------
  def current_user?(user)
    user == current_user
  end

  #---------------------------------------------------------------
  def authenticate
    deny_access unless signed_in?
  end

  #---------------------------------------------------------------
  def deny_access
    store_location
    redirect_to signin_path, :notice => Const::STR_MSG_NEED_TO_BE_SIGNED_IN
  end

  #---------------------------------------------------------------
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  #---------------------------------------------------------------
  def current_company
    @current_company ||= session[:current_company]
  end

  #---------------------------------------------------------------
  def switch_current_company(company)  # TODO: check possibility to switch between companies
    if company && session[:companies]
      if session[:companies].index(company)
        @current_company = company
        session[:current_company] = company
        store_privileges   # re-read privileges
      end
    end
  end

  #---------------------------------------------------------------
  def privilege_granted?(class_name, action_name)
    result = false
    if signed_in?
      if current_user.admin?
        result = true
      else
        if class_name && action_name
          class_name  = class_name.downcase
          action_name = action_name.downcase
          session[:privileges].each do |p|
            result = (p[0] == class_name) && (p[1] == action_name)
            break if result
          end
        end
      end
    end
    result
  end

  #---------------------------------------------------------------
  def check_privileges!
    if !privilege_granted?(@protected_class, @protected_action)
      redirect_to root_path, :notice => Const::STR_MSG_ACCESS_DENIED
    end
  end

  #---------------------------------------------------------------
  def convert_date_from_selection(param_array, param_name)
    return Date.civil(param_array[param_name + '(1i)'].to_i,
                      param_array[param_name + '(2i)'].to_i,
                      param_array[param_name + '(3i)'].to_i)
  end

  #---------------------------------------------------------------
  def format_local_ts(utc_timestamp)
    utc_timestamp.utc.getlocal.strftime("%d-%m-%Y %H:%M")
  end

  #---------------------------------------------------------------
  def format_if_empty(value)
    (value && (value.to_s.size > 0)) ? value : "-"
  end

  private

    #---------------------------------------------------------------
    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end

    #---------------------------------------------------------------
    def remember_token
      cookies.signed[:rynda_remember_token] || [nil, nil]
    end

    #---------------------------------------------------------------
    def store_location
      session[:return_to] = request.fullpath
    end

    #---------------------------------------------------------------
    def clear_return_to
      session[:return_to] = nil
    end

    #---------------------------------------------------------------
    def store_companies
      session[:companies] = current_user ? current_user.available_companies : []
      session[:current_company] = (session[:companies].count > 0) ?
                                   session[:companies][0] : nil
    end

    #---------------------------------------------------------------
    def store_privileges
      session[:privileges] = session[:current_company] ? 
                             current_user.privileges_at_company(session[:current_company]) : []
    end

end
