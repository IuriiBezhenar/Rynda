# encoding: utf-8

# shared application's constants
class Const

  MODEL_CLASS_NAME_SYSTYPE             = "Systype"
  MODEL_CLASS_NAME_DESCRIPTOR          = "Descriptor"
  MODEL_CLASS_NAME_CONTACT             = "Contact"
  MODEL_CLASS_NAME_COMPANY             = "Company"
  MODEL_CLASS_NAME_USER                = "User"
  MODEL_CLASS_NAME_ROLE                = "Role"
  MODEL_CLASS_NAME_COMMUNITY           = "Community"
  MODEL_CLASS_NAME_USER_COMMUNITY      = "UserCommunity"
  MODEL_CLASS_NAME_SERVICE_REQUEST     = "ServiceRequest"
  MODEL_CLASS_NAME_SERVICE_OPERATION   = "ServiceOperation"

  CLASS_KEY_OBJECT_TYPE                = "OBJECT_TYPE"
  ID_OBJECT_TYPE_SERVICE_REQUEST       = 101
  ID_OBJECT_TYPE_SERVICE_OPERATION     = 102

  CLASS_KEY_DESCRIPTOR_TYPE            = "DESCRIPTOR_TYPE"
  ID_DESCRIPTOR_TYPE_STUB              = 111

  CLASS_KEY_USER_STATUS                = "USER_STATUS"
  ID_USER_STATUS_NEW                   = 121
  ID_USER_STATUS_ACTIVE                = 122
  ID_USER_STATUS_DISABLED              = 123

  CLASS_KEY_CONTACT_TYPE               = "CONTACT_TYPE"
  ID_CONTACT_TYPE_COMPANY              = 131
  ID_CONTACT_TYPE_BUSINESS_UNIT        = 132
  ID_CONTACT_TYPE_DEPARTMENT           = 133

  CLASS_KEY_CONTACT_STATUS             = "CONTACT_STATUS"
  ID_CONTACT_STATUS_ACTIVE             = 141
  ID_CONTACT_STATUS_INACTIVE           = 142

  CLASS_KEY_SERVICE_REQ_TYPE           = "SERVICE_REQUEST_TYPE"
  ID_SERVICE_REQ_TYPE_HARDWARE_FAILURE = 201
  ID_SERVICE_REQ_TYPE_CARTRIDGE_CHANGE = 202
  ID_SERVICE_REQ_TYPE_SOFTWARE_FAILURE = 203
  ID_SERVICE_REQ_TYPE_SOFTWARE_INSTALL = 204

  CLASS_KEY_SERVICE_REQ_STATUS         = "SERVICE_REQUEST_STATUS"
  ID_SERVICE_REQ_STATUS_DRAFT          = 211
  ID_SERVICE_REQ_STATUS_SENT           = 212
  ID_SERVICE_REQ_STATUS_RECEIVED       = 213
  ID_SERVICE_REQ_STATUS_ASSIGNED       = 214
  ID_SERVICE_REQ_STATUS_ACTIVATED      = 215
  ID_SERVICE_REQ_STATUS_PROCESSED      = 216
  ID_SERVICE_REQ_STATUS_APPROVED       = 217
  ID_SERVICE_REQ_STATUS_RETURNED       = 218
  ID_SERVICE_REQ_STATUS_CANCELED       = 219

  CLASS_KEY_SERVICE_OPER_TYPE          = "SERVICE_OPERATION_TYPE"
  ID_SERVICE_OPER_TYPE_HARDWARE_FAILURE= 221
  ID_SERVICE_OPER_TYPE_CARTRIDGE_CHANGE= 222
  ID_SERVICE_OPER_TYPE_SOFTWARE_FAILURE= 223
  ID_SERVICE_OPER_TYPE_SOFTWARE_INSTALL= 224

  CLASS_KEY_SERVICE_OPER_STATUS        = "SERVICE_OPERATION_STATUS"
  ID_SERVICE_OPER_STATUS_DRAFT         = 231
  ID_SERVICE_OPER_STATUS_PLANNED       = 232
  ID_SERVICE_OPER_STATUS_ASSIGNED      = 233
  ID_SERVICE_OPER_STATUS_ACTIVATED     = 234
  ID_SERVICE_OPER_STATUS_COMMITTED     = 235
  ID_SERVICE_OPER_STATUS_ACCEPTED      = 236
  ID_SERVICE_OPER_STATUS_REJECTED      = 237
  ID_SERVICE_OPER_STATUS_CANCELED      = 238

  CLASS_KEY_HARDWARE_TYPE              = "HARDWARE_TYPE"
  ID_HARDWARE_TYPE_COMPUTER            = 501
  ID_HARDWARE_TYPE_MONITOR             = 502
  ID_HARDWARE_TYPE_KEYBOARD            = 503
  ID_HARDWARE_TYPE_MOUSE               = 504
  ID_HARDWARE_TYPE_PRINTER             = 505
  ID_HARDWARE_TYPE_MFU                 = 506

  #=====================================================================
  STR_URL_LAYOUTS_STYLESHEETS          = 'layouts/stylesheets'
  STR_URL_LAYOUTS_HEADER               = 'layouts/header'
  STR_URL_LAYOUTS_FOOTER               = 'layouts/footer'
  STR_URL_FORM_SUBMIT                  = 'shared/form_submit'
  STR_URL_ERROR_MESSAGES               = 'shared/error_messages'
  STR_URL_USER_INFO                    = 'shared/user_info'
  STR_URL_USER_STATS                   = 'shared/stats'
  STR_URL_ACCESS_DENIED                = '/shared/access_denied'
  STR_URL_FIELDS                       = 'fields'
  STR_URL_FIELDS_ON_CREATE             = 'fields_on_create'
  STR_URL_FIELDS_ON_SHOW               = 'fields_on_show'
  STR_URL_PRIV_ACTIONS                 = 'priv_actions'
  STR_URL_BUSINESS_UNIT_LIST           = 'business_units/business_unit_list'
  STR_URL_FORM_HEADER                  = 'shared/form_header'
  STR_URL_LIST_HEADER                  = 'list_header'
  STR_URL_SELECTOR_CONTROL             = 'selector_control'
  STR_URL_SERVICE_OPERATIONS_ROOT      = 'service_operations/'
  STR_URL_OPERATIONS_ON_REQUEST        = 'operations_on_request'
  STR_URL_USER_ROLES                   = 'user_roles'
  STR_URL_SELECTED_LIST                = 'selected_list'

  STR_TITLE_SIGN_UP                    = "Sign up"
  STR_TITLE_SIGN_IN                    = "Sign in"
  STR_TITLE_ALL_USERS                  = "All users"
  STR_TITLE_EDIT_USER                  = "Edit user"
  STR_TITLE_NEW_COMPANY                = "New company"
  STR_TITLE_EDIT_COMPANY               = "Edit company"
  STR_TITLE_NEW_BUSINESS_UNIT          = "New business unit"
  STR_TITLE_EDIT_BUSINESS_UNIT         = "Edit business unit"
  STR_TITLE_NEW_SERV_REQ               = "New service request"
  STR_TITLE_EDIT_SERV_REQ              = "Edit service request"
  STR_TITLE_NEW_SERV_OPER              = "New service operation"
  STR_TITLE_EDIT_SERV_OPER             = "Edit service operation"
  STR_TITLE_NEW_ROLE                   = "New role"
  STR_TITLE_ALL_ROLES                  = "All roles"
  STR_TITLE_SHOW_ROLE                  = "Show role"
  STR_TITLE_EDIT_ROLE                  = "Edit role"
  STR_TITLE_NEW_COMMUNITY              = "New community"
  STR_TITLE_ALL_COMMUNITIES            = "All communities"
  STR_TITLE_SHOW_COMMUNITY             = "Show community"
  STR_TITLE_EDIT_COMMUNITY             = "Edit community"

  STR_ACTION_ABOUT                     = "О проекте"
  STR_ACTION_ACTIVATE_SERV_OPER        = "Активировать"
  STR_ACTION_ASSIGN_SERV_OPER          = "Назначить"
  STR_ACTION_APPROVE_SERV_REQ          = "Подтв.выполнение"
  STR_ACTION_CANCEL_SERV_OPER          = "Отменить"
  STR_ACTION_CONTACT_LIST              = "Контакты"
  STR_ACTION_COMMIT_SERV_OPER          = "Завершить"
  STR_ACTION_COMMUNITY_LIST            = "Группы"
  STR_ACTION_COMPANY_LIST              = "Компании"
  STR_ACTION_CREATE                    = "Создать"
  STR_ACTION_CREATE_COMMUNITY          = "Создать группу"
  STR_ACTION_CREATE_COMPANY            = "Создать компанию"
  STR_ACTION_CREATE_ROLE               = "Создать роль"
  STR_ACTION_CREATE_SERV_OPER          = "Создать операцию"
  STR_ACTION_CREATE_SERV_REQ           = "Создать запрос"
  STR_ACTION_DELETE                    = "Удалить"
  STR_ACTION_EDIT                      = "Редактировать"
  STR_ACTION_HELP                      = "Помощь"
  STR_ACTION_MAIN_PAGE                 = "Главная"
  STR_ACTION_MANAGE_ROLES              = "Упр.ролями"
  STR_ACTION_MANAGE_PRIVILEGES         = "Упр.правами"
  STR_ACTION_MANAGE_MEMBERS            = "Упр.составом"
  STR_ACTION_NEW_BUSINESS_UNIT         = "Новое бизнес-направление"
  STR_ACTION_PLAN_SERV_OPER            = "Запланировать"
  STR_ACTION_RECEIVE_SERV_REQ          = "Принять"
  STR_ACTION_RELOAD_DATA               = "Обновить данные"
  STR_ACTION_RETURN_SERV_REQ           = "Возобновить"
  STR_ACTION_ROLE_LIST                 = "Роли"
  STR_ACTION_SAVE_CHANGES              = "Сохранить изменения"
  STR_ACTION_SEND_SERV_REQ             = "Отослать"
  STR_ACTION_SERV_OPER_LIST            = "Сервисные операции"
  STR_ACTION_SERV_REQ_LIST             = "Запросы на обслуживание"
  STR_ACTION_SIGN_IN                   = "Войти"
  STR_ACTION_SIGN_OUT                  = "Выйти"
  STR_ACTION_SIGN_UP                   = "Зарегистрироваться"
  STR_ACTION_SHOW_STATUS_TRACK         = "История"
  STR_ACTION_USER_LIST                 = "Пользователи"
  STR_ACTION_USER_PROFILE              = "Настройки"

  STR_FIELD_NAME_ARCHIVE               = "archive"
  STR_FIELD_NAME_COMPANY_ID            = "company_id"
  STR_FIELD_NAME_CREATED_AT            = "created_at"
  STR_FIELD_NAME_DATE_FROM             = "date_from"
  STR_FIELD_NAME_DATE_TO               = "date_to"
  STR_FIELD_NAME_ID                    = "id"
  STR_FIELD_NAME_INSPECTOR_ID          = "inspector_id"
  STR_FIELD_NAME_MODERATOR_ID          = "moderator_id"
  STR_FIELD_NAME_NAME                  = "name"
  STR_FIELD_NAME_OWNED_ONLY            = "owned_only"
  STR_FIELD_NAME_PARENT_ID             = "parent_id"
  STR_FIELD_NAME_PROCESSABLE           = "processable"
  STR_FIELD_NAME_PERFORMER_ID          = "performer_id"
  STR_FIELD_NAME_REQUESTER_ID          = "requester_id"
  STR_FIELD_NAME_STATUS_ID             = "status_id"
  STR_FIELD_NAME_STATUS_DATE           = "status_date"
  STR_FIELD_NAME_TYPE_ID               = "type_id"

  STR_LABEL_ADDITIONAL_INFO            = "Доп.информация"
  STR_LABEL_ACTIONS                    = "Действия"
  STR_LABEL_ACTIVATION                 = "Активация"
  STR_LABEL_ARCHIVE                    = "Архивные"
  STR_LABEL_ASSIGN                     = "Назначить"
  STR_LABEL_ASSIGNOR                   = "Поручитель"
  STR_LABEL_CALLBACK_INFO              = "Обратная связь"
  STR_LABEL_CANCELLATION               = "Отмена"
  STR_LABEL_COMPANY                    = "Компания"
  STR_LABEL_COMPANY_LIST               = "Список компаний"
  STR_LABEL_CREATED_AT                 = "Дата создания"
  STR_LABEL_CURRENT_COMPANY            = "Текущая компания"
  STR_LABEL_DATE_FROM                  = "С даты"
  STR_LABEL_DATE_TO                    = "По дату"
  STR_LABEL_DESCRIPTION                = "Примечание"
  STR_LABEL_EMAIL                      = "Почтовый ящик"
  STR_LABEL_EXCLUDE                    = "Исключить"
  STR_LABEL_GRANT                      = "Назначить"
  STR_LABEL_HARDWARE_TYPE              = "Тип оборудования"
  STR_LABEL_HARDWARE_INFO              = "Модель оборудования"
  STR_LABEL_ID                         = "Служ.#"
  STR_LABEL_INCLUDE                    = "Включить"
  STR_LABEL_INSPECTOR                  = "Контролер"
  STR_LABEL_INSTRUCTIONS               = "Предписания"
  STR_LABEL_LOCATION_INFO              = "Кабинет/Помещение"
  STR_LABEL_LOGIN                      = "Имя учетной записи"
  STR_LABEL_MEMBERSHIP                 = "Состоит"
  STR_LABEL_MODERATOR                  = "Модератор"
  STR_LABEL_MY_PROFILE                 = "Мой профиль"
  STR_LABEL_NAME                       = "Наименование"
  STR_LABEL_OPERABLE_REQUEST           = "Запрос-основание"
  STR_LABEL_OWNED_ONLY                 = "Только мои"
  STR_LABEL_PASSWORD                   = "Пароль"
  STR_LABEL_PASSWORD_CONFIRMATION      = "Повторный ввод пароля"
  STR_LABEL_PERFORMER                  = "Исполнитель"
  STR_LABEL_PERFORMING_COMMUNITY       = "Группа исполнителей"
  STR_LABEL_PRIVILEGED_ACTION          = "Привилегированное действие"
  STR_LABEL_PRIVILEGES                 = "Права"
  STR_LABEL_PROCESSABLE                = "Обрабатываемые"
  STR_LABEL_REMARKS                    = "Замечания"
  STR_LABEL_REPORT                     = "Отчет"
  STR_LABEL_REQUESTER                  = "Заказчик"
  STR_LABEL_REVOKE                     = "Отозвать"
  STR_LABEL_ROLE_NAME                  = "Наименование роли"
  STR_LABEL_STATUS                     = "Статус"
  STR_LABEL_STATUS_DATE                = "Дата смены статуса"
  STR_LABEL_STATUS_TRACK               = " (история смены статусов)"
  STR_LABEL_SERVICE_OPERATION          = "Сервисная операция"
  STR_LABEL_SERVICE_REQUEST            = "Запрос на обслуживание"
  STR_LABEL_SERV_OPER_TYPE             = "Тип операции"
  STR_LABEL_SERV_OPER_QUEUE            = "Очередь сервисных операций"
  STR_LABEL_SERV_REQ_TYPE              = "Тип запроса"
  STR_LABEL_SERV_REQ_QUEUE             = "Очередь запросов на обслуживание"
  STR_LABEL_TYPE                       = "Тип"
  STR_LABEL_USER                       = "Пользователь"
  STR_LABEL_USER_NAME                  = "ФИО пользователя"
  STR_LABEL_WITHDRAW                   = "Отозвать"

  STR_MSG_APPLICATION_TITLE            = "RYNDA"
  STR_MSG_APPLICATION_NAME             = "HELP DESK SYSTEM - EVERYWHERE YOU ARE"
  STR_MSG_APPLICATION_INFO             = "Платформа для процессов обслуживания компании"
  STR_MSG_APPLICATION_ABOUT            = "About help-desk system - Rynda"
  STR_MSG_APPLICATION_CONTACTS         = "Контакты"
  STR_MSG_APPLICATION_HELP             = "Описание системы <Рында>"
  STR_MSG_HELP_SHORT_DESCRIPTION       = "звоните 911"
  STR_MSG_WELCOME_ABOARD               = "Добро пожаловать в нашу систему !"
  STR_MSG_NEED_TO_BE_SIGNED_IN         = "Необходимо зарегистироваться в системе"
  STR_MSG_EXPORT_XLS                   = "Экспорт в MS Excel"
  STR_MSG_ACCESS_DENIED                = "<<< Доступ не разрешен >>>"
  STR_MSG_ADMIN_DESTROY_PROTECTION     = "Учетная запись администратора не может быть удалена"
  STR_MSG_NEW_USER_REGISTRATION        = "Регистрация учетной записи пользователя"
  STR_MSG_USER_DELETION_CONFIRM        = "Подтвердите удаление пользователя"
  STR_MSG_SUCCESS_USER_DELETION        = "Пользователь успешно удален"
  STR_MSG_SUCCESS_USER_UPDATE          = "Профиль пользователя изменен"
  STR_MSG_USER_SIGN_IN                 = "Вход пользователя"
  STR_MSG_USER_LIST                    = "Список пользователей системы"
  STR_MSG_FIRST_TIME_AT_SITE           = "Впервые на сайте?"
  STR_MSG_SIGN_UP_NOW                  = "Зарегистрируйтесь прямо сейчас!"
  STR_MSG_SAVE_CHANGES                 = "Сохранить изменения"
  STR_MSG_MAKE_DELETION                = "Удалить"
  STR_MSG_INVALID_SIGN_IN_PARAMS       = "Неверная комбинация имени и пароля"
  STR_MSG_EDIT_USER_PROFILE            = "Редактирование учетной записи пользователя"
  STR_MSG_EMPTY_COMPANY_LIST           = "Список компаний пуст"
  STR_MSG_NEW_COMPANY_CREATION         = "Ввод новой компании"
  STR_MSG_EDIT_COMPANY                 = "Редактирование компании"
  STR_MSG_SUCCESS_COMPANY_CREATION     = "Компания успешно создана"
  STR_MSG_SUCCESS_COMPANY_UPDATE       = "Компания успешно изменена"
  STR_MSG_SUCCESS_COMPANY_DELETION     = "Компания успешно удалена"
  STR_MSG_FAILURE_COMPANY_DELETION     = "Удаление компании не выполнено"
  STR_MSG_COMPANY_DELETION_CONFIRM     = "Подтвердите удаление компании"
  STR_MSG_NEW_BUSINESS_UNIT_CREATION   = "Ввод нового бизнес-направления"
  STR_MSG_SUCCESS_BSNS_UNIT_CREATION   = "Бизнес-направление успешно создано"
  STR_MSG_SUCCESS_BSNS_UNIT_UPDATE     = "Бизнес-направление успешно изменено"
  STR_MSG_SUCCESS_BSNS_UNIT_DELETION   = "Бизнес-направление успешно удалено"
  STR_MSG_FAILURE_BSNS_UNIT_DELETION   = "Удаление бизнес-направления не выполнено"
  STR_MSG_NEW_SERV_REQ_CREATION        = "Создание нового запроса на обслуживание"
  STR_MSG_EDIT_SERV_REQ                = "Редактирование запроса на обслуживание"
  STR_MSG_SERV_REQ_DELETION_CONFIRM    = "Подтвердите удаление запроса на обслуживание"
  STR_MSG_SUCCESS_SERV_REQ_CREATION    = "Запрос на обслуживание успешно создан"
  STR_MSG_SUCCESS_SERV_REQ_UPDATE      = "Запрос на обслуживание успешно изменен"
  STR_MSG_SUCCESS_SERV_REQ_DELETION    = "Запрос на обслуживание успешно удален"
  STR_MSG_FAILURE_SERV_REQ_DELETION    = "Удаление запроса на обслуживание не выполнено"
  STR_MSG_SERV_REQ_SENDING_CONFIRM     = "Подтвердите отсылку запроса на обслуживание"
  STR_MSG_MAKE_SENDING                 = "Отослать"
  STR_MSG_SUCCESS_SERV_REQ_SENDING     = "Запрос на поддержку успешно отослан"
  STR_MSG_FAILURE_SERV_REQ_SENDING     = "Ошибка при отсылке запроса на поддержку"
  STR_MSG_SERV_REQ_RECEIVING_CONFIRM   = "Подтвердите прием запроса на обслуживание"  # ?
  STR_MSG_UNRECEIVABLE_SERV_REQ        = "Запрос на поддержку не может быть принят"
  STR_MSG_MAKE_RECEIVING               = "Принять"
  STR_MSG_INDEPENDENT_OPERATION        = "- без запроса на поддержку -"
  STR_MSG_NO_OPER_PERFORMERS_EXIST     = " : отсутствуют возможные исполнители"
  STR_MSG_NEW_SERV_OPER_CREATION       = "Создание новой сервисной операции"
  STR_MSG_EDIT_SERV_OPER               = "Редактирование сервисной операции"
  STR_MSG_SUCCESS_SERV_OPER_CREATION   = "Сервисная операция успешно создана"
  STR_MSG_SUCCESS_SERV_OPER_UPDATE     = "Сервисная операция успешно изменена"
  STR_MSG_SUCCESS_SERV_OPER_DELETION   = "Сервисная операция успешно удалена"
  STR_MSG_FAILURE_SERV_OPER_DELETION   = "Удаление сервисной операции не выполнено"
  STR_MSG_SERV_OPER_DELETION_CONFIRM   = "Подтвердите удаление сервисной операции"
  STR_MSG_SERV_OPER_PLANNING_CONFIRM   = "Подтвердите планирование сервисной операции"
  STR_MSG_MAKE_PLANNING                = "Запланировать"
  STR_MSG_SUCCESS_SERV_OPER_PLANNING   = "Сервисная операция успешно запланирована"
  STR_MSG_FAILURE_SERV_OPER_PLANNING   = "Не удалось запланировать сервисную операцию"
  STR_MSG_SUCCESS_SERV_REQ_RECEVING    = "Запрос на обслуживание успешно принят"
  STR_MSG_FAILURE_SERV_REQ_RECEVING    = "Не удалось выполнить прием запроса на обслуживание"
  STR_MSG_UNAPPROVABLE_SERV_REQ        = "Выполнение запроса на обслуживание не может быть подтверждено"
  STR_MSG_UNRETURNABLE_SERV_REQ        = "Запрос на обслуживание не может быть возвращен"
  STR_MSG_SUCCESS_SERV_REQ_APPROVING   = "Выполнение запроса на обслуживание успешно подтверждено"
  STR_MSG_FAILURE_SERV_REQ_APPROVING   = "Не удалось подтвердить выполнение запроса на обслуживание"
  STR_MSG_SUCCESS_SERV_REQ_RETURNING   = "Возврат в работу запроса на обслуживание произведен успешно"
  STR_MSG_FAILURE_SERV_REQ_RETURNING   = "Не удалось вернуть в работу запрос на обслуживание"
  STR_MSG_SUCCESS_SERV_OPER_ASSIGNING  = "Сервисная операция успешно назначена"
  STR_MSG_FAILURE_SERV_OPER_ASSIGNING  = "Не удалось назначить сервисную операцию"
  STR_MSG_UNASSIGNABLE_SERV_OPER       = "Сервисная операция не может быть назначена"
  STR_MSG_SUCCESS_SERV_OPER_ACTIVATION = "Сервисная операция успешно активирована"
  STR_MSG_FAILUER_SERV_OPER_ACTIVATION = "Не удалось активировать сервисную операцию"
  STR_MSG_INACTIVATED_SERV_OPER        = "Сервисная операция не может быть начата"
  STR_MSG_NON_CANCELED_SERV_OPER       = "Данную сервисную операцию отменить нельзя"
  STR_MSG_SUCCESS_SERV_OPER_CANCEL     = "Сервисная операция успешно отменена"
  STR_MSG_FAILURE_SERV_OPER_CANCEL     = "Не удалось отменить сервисную операцию"
  STR_MSG_UNCOMMITTED_SERV_OPER        = "Сервисная операция не может быть завершена"
  STR_MSG_SUCCESS_SERV_OPER_COMMITTING = "Сервисная операция успешно завершена"
  STR_MSG_FAILURE_SERV_OPER_COMMITTING = "Не удалось завершить сервисную операцию"
  STR_MSG_OPERATIONS_ON_REQUEST        = "Сервисные операции по запросу"
  STR_MSG_SUCCESS_ROLE_CREATION        = "Пользовательская роль успешно создана"
  STR_MSG_SUCCESS_ROLE_UPDATE          = "Пользовательская роль успешно изменена"
  STR_MSG_SUCCESS_ROLE_DELETION        = "Пользовательская роль успешно удалена"
  STR_MSG_FAILURE_ROLE_DELETION        = "Удаление пользовательской роли не выполнено"
  STR_MSG_ROLE_DELETION_CONFIRM        = "Подвердите удаление пользовательской роли"
  STR_MSG_EDIT_ROLE                    = "Изменение пользовательской роли"
  STR_MSG_NEW_ROLE_CREATION            = "Создание новой роли"
  STR_MSG_ROLE_LIST                    = "Пользовательские роли"
  STR_MSG_EMPTY_ROLE_LIST              = "Список пользовательских ролей пуст"
  STR_MSG_ASSIGNED_ROLES               = "Назначенные роли"
  STR_MSG_AVAILABLE_ROLES              = "Доступные роли"
  STR_MSG_NO_ASSIGNED_ROLES            = "Назначенные роли отсутствуют"
  STR_MSG_NO_ASSIGNABLE_ROLES          = "Доступные роли отсутствуют"
  STR_MSG_ROLE_MANAGEMENT              = "Управление ролями пользователя"
  STR_MSG_GRANTED_ROLE_COUNT           = "Назначено ролей: "
  STR_MSG_REVOKED_ROLE_COUNT           = "Отозвано ролей: "
  STR_MSG_PRIVILEGE_MANAGEMENT         = "Управление правами роли"
  STR_MSG_ROLE_NOT_FOUND               = "Role not found, ID="
  STR_MSG_GRANTED_PRIVILEGE_COUNT      = "Назначено привилегий: "
  STR_MSG_REVOKED_PRIVILEGE_COUNT      = "Отозвано привилегий: "
  STR_MSG_BAD_DATA_FORMAT              = "Bad data format: "
  STR_MSG_PRIVILEGE_NOT_FOUND          = "Privilege not found: "
  STR_MSG_COMMUNITY_DELETION_CONFIRM   = "Подтвердите удаление пользовательской группы"
  STR_MSG_COMMUNITY_LIST               = "Список пользовательских групп"
  STR_MSG_EMPTY_COMMUNITY_LIST         = "Список пользовательских групп пуст"
  STR_MSG_NEW_COMMUNITY_CREATION       = "Создание новой пользовательской группы"
  STR_MSG_SUCCESS_COMMUNITY_CREATION   = "Пользовательская группа успешно создана"
  STR_MSG_SUCCESS_COMMUNITY_UPDATE     = "Пользовательская группа успешно изменена"
  STR_MSG_SUCCESS_COMMUNITY_DELETION   = "Пользовательская группа успешно удалена"
  STR_MSG_FAILURE_COMMUNITY_DELETION   = "Удаление пользовательской группы не выполнено"
  STR_MSG_INCLUDED_MEMBER_COUNT        = "Включено в группу: "
  STR_MSG_EXCLUDED_MEMBER_COUNT        = "Исключено из группы: "
  STR_MSG_USER_COMMUNITY_NOT_FOUND     = "Связь пользователя и группы не найдена: "
  STR_MSG_MEMBER_MANAGEMENT            = "Управление составом пользовательской группы"
  STR_MSG_CURRENT_COMPANY_MISSING      = "<нет доступных компаний>"
  STR_MSG_SWITCH_CURRENT_COMPANY       = "Смена текущей компании"
  STR_MSG_SWITCH_TO_COMPANY            = "Выбрать компанию"
  STR_MSG_BLANK_COMMUNITY              = "- нет группы -"
  STR_MSG_SOME_TEXT_NEEDED             = "!! введите описание !!"
  STR_MSG_SET_SELECTORS_AND_RELOAD     = "установите параметры отбора и обновите данные"
  STR_MSG_NO_RECORD_FOUND              = "записей не найдено"
  STR_MSG_SET_OF_SELECTORS_IS_WRONG    = "Неверная комбинация параметров: для архивных данных " +
                                         "параметр <#{STR_LABEL_DATE_FROM}> не может быть пустым"

  # STR_VALUE_DEFAULT_SMTP_SERVER        = "192.168.129.1" - не удалось подключить в environment.rb
  STR_VALUE_APPLICATION_NAME           = "rynda"
  STR_VALUE_LOGO_IMAGE_FILE_NAME       = "logo_ext.jpg"
  STR_VALUE_XLS_IMAGE_FILE_NAME        = "xls.jpg"
  STR_VALUE_CHECK_IMAGE_FILE_NAME      = "check.jpg"
  STR_VALUE_SELECT_PERFORMER           = "select_performer"
  STR_VALUE_SELECT_COMMUNITY           = "select_community"
  STR_VALUE_REPORTING                  = "reporting"
  STR_VALUE_DEFAULT_MAIL_SENDER        = "admin@fortuna.odessa.ua"
  STR_VALUE_SQL_DESC                   = " desc"
  STR_VALUE_ALIAS                      = "alias"
  STR_VALUE_ACTIONS                    = "actions"
  STR_VALUE_DEFAULT_RAILS_DATE_FORMAT  = "%d %m %Y"
  STR_VALUE_DEFAULT_JS_DATE_FORMAT     = "dd.mm.yy"  # or "dd.mm.y" for 2-digit year
  STR_VALUE_CALLBACK                   = "callback"

  #=====================================================================
  STR_CLASS_USERS_CONTR                = "userscontroller"
  STR_CLASS_ROLES_CONTR                = "rolescontroller"
  STR_CLASS_COMPANIES_CONTR            = "companiescontroller"
  STR_CLASS_COMMUNITIES_CONTR          = "communitiescontroller"
  STR_CLASS_SERVICE_REQUESTS_CONTR     = "servicerequestscontroller"
  STR_CLASS_SERVICE_OPERATIONS_CONTR   = "serviceoperationscontroller"

  #=====================================================================
  STR_PA_ACCESS                        = "access"
  STR_PA_CREATE                        = "create"
  STR_PA_DESTROY                       = "destroy"
  STR_PA_INDEX                         = "index"
  STR_PA_GET_TO_PERFORM                = "get_to_perform"
  STR_PA_MAKE_ACTIVATED                = "make_activated"
  STR_PA_MAKE_APPROVED                 = "make_approved"
  STR_PA_MAKE_ASSIGNED                 = "make_assigned"
  STR_PA_MAKE_CANCELED                 = "make_canceled"
  STR_PA_MAKE_COMMITTED                = "make_committed"
  STR_PA_MAKE_PLANNED                  = "make_planned"
  STR_PA_MAKE_RECEIVED                 = "make_received"
  STR_PA_MAKE_RETURNED                 = "make_returned"
  STR_PA_MAKE_SENT                     = "make_sent"
  STR_PA_PROCESS_MEMBERS               = "process_members"
  STR_PA_PROCESS_PRIVILEGES            = "process_privileges"
  STR_PA_PROCESS_ROLES                 = "process_roles"
  STR_PA_SHOW_STATUS_TRACK             = "show_status_track"
  STR_PA_UPDATE                        = "update"

  #=====================================================================
  HASH_REQUEST_OPERATION_TYPE = {
    ID_SERVICE_REQ_TYPE_HARDWARE_FAILURE => ID_SERVICE_OPER_TYPE_HARDWARE_FAILURE,
    ID_SERVICE_REQ_TYPE_CARTRIDGE_CHANGE => ID_SERVICE_OPER_TYPE_CARTRIDGE_CHANGE,
    ID_SERVICE_REQ_TYPE_SOFTWARE_FAILURE => ID_SERVICE_OPER_TYPE_SOFTWARE_FAILURE,
    ID_SERVICE_REQ_TYPE_SOFTWARE_INSTALL => ID_SERVICE_OPER_TYPE_SOFTWARE_INSTALL }

  HASH_MODEL_PRIVILEGED_ACTIONS = {
    STR_CLASS_USERS_CONTR =>
      { STR_VALUE_ALIAS => "Учетные записи пользователей",
        STR_VALUE_ACTIONS => {
          STR_PA_INDEX                 => "Просмотр списка пользователей",
          STR_PA_DESTROY               => "Удаление учетной записи",
          STR_PA_PROCESS_ROLES         => "Управление ролями пользователя"
        }
      },
    STR_CLASS_ROLES_CONTR =>
      { STR_VALUE_ALIAS => "Пользовательские роли",
        STR_VALUE_ACTIONS => {
          STR_PA_INDEX                 => "Просмотр списка ролей",
          STR_PA_CREATE                => "Создание роли",
          STR_PA_UPDATE                => "Изменение параметров роли",
          STR_PA_DESTROY               => "Удаление роли",
          STR_PA_PROCESS_PRIVILEGES    => "Управление привилегиями роли"
        }
      },
    STR_CLASS_COMPANIES_CONTR =>
      { STR_VALUE_ALIAS => "Компании (предприятия)",
        STR_VALUE_ACTIONS => {
          STR_PA_INDEX                 => "Просмотр списка компаний",
          STR_PA_UPDATE                => "Изменение параметров компании",
          STR_PA_CREATE                => "Создание новой компании",
          STR_PA_DESTROY               => "Удаление компании"
        }
      },
    STR_CLASS_COMMUNITIES_CONTR =>
      { STR_VALUE_ALIAS => "Группы пользоватей",
        STR_VALUE_ACTIONS => {
          STR_PA_INDEX                 => "Просмотр списка групп",
          STR_PA_UPDATE                => "Изменение параметров группы",
          STR_PA_CREATE                => "Создание новой группы",
          STR_PA_DESTROY               => "Удаление пустой группы"
        }
      },
    STR_CLASS_SERVICE_REQUESTS_CONTR =>
      { STR_VALUE_ALIAS => "Запросы на обслуживание",
        STR_VALUE_ACTIONS => {
          STR_PA_INDEX                 => "Просмотр списка запросов на обслуживание",
          STR_PA_CREATE                => "Создать новый запрос на обслуживание",
          STR_PA_UPDATE                => "Изменение параметров запроса",
          STR_PA_DESTROY               => "Удаление запроса на обслуживание",
          STR_PA_MAKE_SENT             => "Отправка запроса на обслуживание",
          STR_PA_MAKE_RECEIVED         => "Прием запроса для обработки",
          STR_PA_SHOW_STATUS_TRACK     => "Просмотр истории изменения статуса"
        }
      },
    STR_CLASS_SERVICE_OPERATIONS_CONTR =>
      { STR_VALUE_ALIAS => "Сервисные операции",
        STR_VALUE_ACTIONS => {
          STR_PA_INDEX                 => "Просмотр списка сервисных операций",
          STR_PA_CREATE                => "Создать новую сервисную операцию",
          STR_PA_UPDATE                => "Изменение параметров операции",
          STR_PA_DESTROY               => "Удаление сервисной операции",
          STR_PA_MAKE_PLANNED          => "Планирование сервисной операции",
          STR_PA_MAKE_ASSIGNED         => "Назначение операции на исполнителя",
          STR_PA_GET_TO_PERFORM        => "Получение назначения на исполнение операции",
          STR_PA_MAKE_ACTIVATED        => "Начало исполнения операции",
          STR_PA_MAKE_COMMITTED        => "Завершение исполнения операции",
          STR_PA_MAKE_CANCELED         => "Отмена сервисной операции",
          STR_PA_SHOW_STATUS_TRACK     => "Просмотр истории изменения статуса"
        }
      }
  }
  #=====================================================================

  INT_VALUE_SESSION_TIME_IN_SEC        = 14400   # expiration time in seconds
  INT_SHORT_STRING_LENGTH              =  25
  INT_NAME_SHORT_LENGTH                =  50
  INT_NAME_STANDARD_LENGTH             = 100
  INT_DESCRIPTION_LENGTH               = 255

end
