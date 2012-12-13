# encoding: utf-8
# 
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

require 'const'

# create predefined types
Systype.delete_all
#-----------------------------------------
Systype.create!(
  :id        => Const::ID_OBJECT_TYPE_SERVICE_REQUEST,
  :name      => 'Запрос на обслуживание',
  :class_key => Const::CLASS_KEY_OBJECT_TYPE
)

Systype.create!(
  :id        => Const::ID_OBJECT_TYPE_SERVICE_OPERATION,
  :name      => 'Операция обслуживания',
  :class_key => Const::CLASS_KEY_OBJECT_TYPE
)

#-------------- USER --------------
Systype.create!(
  :id        => Const::ID_USER_STATUS_NEW,
  :name      => 'Новый',
  :class_key => Const::CLASS_KEY_USER_STATUS
)

Systype.create!(
  :id        => Const::ID_USER_STATUS_ACTIVE,
  :name      => 'Активирован',
  :class_key => Const::CLASS_KEY_USER_STATUS
)

Systype.create!(
  :id        => Const::ID_USER_STATUS_DISABLED,
  :name      => 'Отключен',
  :class_key => Const::CLASS_KEY_USER_STATUS
)

#-------------- CONTACT --------------
Systype.create!(
  :id        => Const::ID_CONTACT_TYPE_COMPANY,
  :name      => 'Компания',
  :class_key => Const::CLASS_KEY_CONTACT_TYPE
)

Systype.create!(
  :id        => Const::ID_CONTACT_TYPE_BUSINESS_UNIT,
  :name      => 'Направление',
  :class_key => Const::CLASS_KEY_CONTACT_TYPE
)

Systype.create!(
  :id        => Const::ID_CONTACT_TYPE_DEPARTMENT,
  :name      => 'Подразделение',
  :class_key => Const::CLASS_KEY_CONTACT_TYPE
)

Systype.create!(
  :id        => Const::ID_CONTACT_STATUS_ACTIVE,
  :name      => 'Активный',
  :class_key => Const::CLASS_KEY_CONTACT_STATUS
)

Systype.create!(
  :id        => Const::ID_CONTACT_STATUS_INACTIVE,
  :name      => 'Неактивный',
  :class_key => Const::CLASS_KEY_CONTACT_STATUS
)


#-------------- SERVICE REQUEST --------------
Systype.create!(
  :id        => Const::ID_SERVICE_REQ_TYPE_HARDWARE_FAILURE,
  :name      => 'Отказ оборудования',
  :class_key => Const::CLASS_KEY_SERVICE_REQ_TYPE
)

Systype.create!(
  :id        => Const::ID_SERVICE_REQ_TYPE_CARTRIDGE_CHANGE,
  :name      => 'Замена картриджа',
  :class_key => Const::CLASS_KEY_SERVICE_REQ_TYPE
)

Systype.create!(
  :id        => Const::ID_SERVICE_REQ_TYPE_SOFTWARE_FAILURE,
  :name      => 'Сбой ПО',
  :class_key => Const::CLASS_KEY_SERVICE_REQ_TYPE
)

Systype.create!(
  :id        => Const::ID_SERVICE_REQ_TYPE_SOFTWARE_INSTALL,
  :name      => 'Установка ПО',
  :class_key => Const::CLASS_KEY_SERVICE_REQ_TYPE
)

Systype.create!(
  :id        => Const::ID_SERVICE_REQ_STATUS_DRAFT,
  :name      => 'Черновой',
  :class_key => Const::CLASS_KEY_SERVICE_REQ_STATUS
)

Systype.create!(
  :id        => Const::ID_SERVICE_REQ_STATUS_SENT,
  :name      => 'Отослан',
  :class_key => Const::CLASS_KEY_SERVICE_REQ_STATUS
)

Systype.create!(
  :id        => Const::ID_SERVICE_REQ_STATUS_RECEIVED,
  :name      => 'Принят',
  :class_key => Const::CLASS_KEY_SERVICE_REQ_STATUS
)

Systype.create!(
  :id        => Const::ID_SERVICE_REQ_STATUS_ASSIGNED,
  :name      => 'Назначен',
  :class_key => Const::CLASS_KEY_SERVICE_REQ_STATUS
)

Systype.create!(
  :id        => Const::ID_SERVICE_REQ_STATUS_ACTIVATED,
  :name      => 'В работе',
  :class_key => Const::CLASS_KEY_SERVICE_REQ_STATUS
)

Systype.create!(
  :id        => Const::ID_SERVICE_REQ_STATUS_PROCESSED,
  :name      => 'Отработан',
  :class_key => Const::CLASS_KEY_SERVICE_REQ_STATUS
)

Systype.create!(
  :id        => Const::ID_SERVICE_REQ_STATUS_APPROVED,
  :name      => 'Подтвержден',
  :class_key => Const::CLASS_KEY_SERVICE_REQ_STATUS
)

Systype.create!(
  :id        => Const::ID_SERVICE_REQ_STATUS_RETURNED,
  :name      => 'Возращен',
  :class_key => Const::CLASS_KEY_SERVICE_REQ_STATUS
)


Systype.create!(
  :id        => Const::ID_SERVICE_REQ_STATUS_CANCELED,
  :name      => 'Отменен',
  :class_key => Const::CLASS_KEY_SERVICE_REQ_STATUS
)

#-------------- SERVICE OPERATION --------------
Systype.create!(
  :id        => Const::ID_SERVICE_OPER_TYPE_HARDWARE_FAILURE,
  :name      => 'Устранение отказа оборудования',
  :class_key => Const::CLASS_KEY_SERVICE_OPER_TYPE
)

Systype.create!(
  :id        => Const::ID_SERVICE_OPER_TYPE_CARTRIDGE_CHANGE,
  :name      => 'Замена картриджа',
  :class_key => Const::CLASS_KEY_SERVICE_OPER_TYPE
)

Systype.create!(
  :id        => Const::ID_SERVICE_OPER_TYPE_SOFTWARE_FAILURE,
  :name      => 'Устранение сбоя ПО',
  :class_key => Const::CLASS_KEY_SERVICE_OPER_TYPE
)

Systype.create!(
  :id        => Const::ID_SERVICE_OPER_TYPE_SOFTWARE_INSTALL,
  :name      => 'Установка ПО',
  :class_key => Const::CLASS_KEY_SERVICE_OPER_TYPE
)

Systype.create!(
  :id        => Const::ID_SERVICE_OPER_STATUS_DRAFT,
  :name      => 'Черновой',
  :class_key => Const::CLASS_KEY_SERVICE_OPER_STATUS
)

Systype.create!(
  :id        => Const::ID_SERVICE_OPER_STATUS_PLANNED,
  :name      => 'Запланирован',
  :class_key => Const::CLASS_KEY_SERVICE_OPER_STATUS
)

Systype.create!(
  :id        => Const::ID_SERVICE_OPER_STATUS_ASSIGNED,
  :name      => 'Назначен',
  :class_key => Const::CLASS_KEY_SERVICE_OPER_STATUS
)

Systype.create!(
  :id        => Const::ID_SERVICE_OPER_STATUS_ACTIVATED,
  :name      => 'Исполняется',
  :class_key => Const::CLASS_KEY_SERVICE_OPER_STATUS
)

Systype.create!(
  :id        => Const::ID_SERVICE_OPER_STATUS_COMMITTED,
  :name      => 'Выполнен',
  :class_key => Const::CLASS_KEY_SERVICE_OPER_STATUS
)

Systype.create!(
  :id        => Const::ID_SERVICE_OPER_STATUS_ACCEPTED,
  :name      => 'Подтвержден',
  :class_key => Const::CLASS_KEY_SERVICE_OPER_STATUS
)

Systype.create!(
  :id        => Const::ID_SERVICE_OPER_STATUS_REJECTED,
  :name      => 'Не засчитан',
  :class_key => Const::CLASS_KEY_SERVICE_OPER_STATUS
)

Systype.create!(
  :id        => Const::ID_SERVICE_OPER_STATUS_CANCELED,
  :name      => 'Отменен',
  :class_key => Const::CLASS_KEY_SERVICE_OPER_STATUS
)

#-------------- HARDWARE TYPE --------------
Systype.create!(
  :id        => Const::ID_HARDWARE_TYPE_COMPUTER,
  :name      => 'Компьютер (системный блок)',
  :class_key => Const::CLASS_KEY_HARDWARE_TYPE
)

Systype.create!(
  :id        => Const::ID_HARDWARE_TYPE_MONITOR,
  :name      => 'Монитор',
  :class_key => Const::CLASS_KEY_HARDWARE_TYPE
)

Systype.create!(
  :id        => Const::ID_HARDWARE_TYPE_KEYBOARD,
  :name      => 'Клавиатура',
  :class_key => Const::CLASS_KEY_HARDWARE_TYPE
)

Systype.create!(
  :id        => Const::ID_HARDWARE_TYPE_MOUSE,
  :name      => 'Манипулятор "мышь"',
  :class_key => Const::CLASS_KEY_HARDWARE_TYPE
)

Systype.create!(
  :id        => Const::ID_HARDWARE_TYPE_PRINTER,
  :name      => 'Принтер',
  :class_key => Const::CLASS_KEY_HARDWARE_TYPE
)

Systype.create!(
  :id        => Const::ID_HARDWARE_TYPE_MFU,
  :name      => 'МФУ (принтер-сканер-копир)',
  :class_key => Const::CLASS_KEY_HARDWARE_TYPE
)

#-----------------------------------------
# predefined company
Company.delete_all

company = Company.create!(
             :id        => 1,
             :name      => "Фортуна FMCG",
             :status_id => Const::ID_CONTACT_STATUS_ACTIVE,
             :descr     => "от заката до рассвета")

# default user community for default company (ALL)
Community.create!(:name   => 'Все',
                  :company_id => company.id,
                  :descr  => 'Полный перечень сотрудников компании')

#-----------------------------------------
# predefined users and groups
#=begin
User.delete_all

admin = User.create!(:status_id => Const::ID_USER_STATUS_ACTIVE,
                     :login     => 'admin',
                     :name      => 'Бен Ладен',
                     :email     => 'bulavin@fortuna.odessa.ua',
                     :password  => '123456',
                     :password_confirmation => '123456')
admin.toggle!(:admin)

3.times do |n|
  login    = "user#{n}"
  name     = n == 1 ? "Петров Иван Сидорович" :
             n == 2 ? "Хо Ши Мин" : "Поджог Сараев"
  email    = "user#{n + 1}@gmail.com"
  password = "111111"
  User.create!(:status_id => Const::ID_USER_STATUS_ACTIVE,
               :login     => login,
               :name      => name,
               :email     => email,
               :password  => password,
               :password_confirmation => password)
end
#=end