class Employee < ApplicationRecord
  belongs_to :manager, :class_name => "Employee", optional: true
  enum classification: [:cashier, :shiftManager, :generalManager]

  has_secure_password
  validates_uniqueness_of :employeeId

  before_validation do |employee|
    id = 0

    if Employee.anyEmployeeExists
      id = Employee.getHighestEmployeeId.to_i + 7
    else
      id = 253
    end
    
    employee.employeeId = id
  end
  
  def self.getHighestEmployeeId 
    return Employee.last.employeeId
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
