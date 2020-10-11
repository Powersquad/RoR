class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to :manager, :class_name => "Employee", optional: true
  enum classification: [:general_manager, :shift_manager, :cashier]

  devise :database_authenticatable, :registerable,
         :rememberable

  validates_presence_of   :email
  validates_uniqueness_of :email
  validates_presence_of     :password
  validates_confirmation_of :password

  before_validation do |employee|
    id = 0
    if Employee.anyEmployeeExists
      id = Employee.getHighestEmployeeId.to_i + 7
      employee.classification = :cashier
    else
      id = 253
      employee.classification = :general_manager
    end
    #validate id here
    puts id.to_s
    puts employee.classification
    employee.email = id.to_s
  end

  def self.getHighestEmployeeId
    return Employee.last.email
  end

  def self.anyEmployeeExists
    return (Employee.first.nil?) ? false : true
  end

  def isElevatedUser
    isElevated = false
    if self.general_manager?
      isElevated = true
    elsif self.shift_manager?
      isElevated = true
    end
    return isElevated
  end
end
