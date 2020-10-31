class EmployeesController < ApplicationController
  #sign in for employee
  def index
    #if first employee
    isFirst = Employee.anyEmployeeExists
    puts isFirst
    if !isFirst
      redirect_to new_employee_path(isFirst: true)
      return
    end
  end

  def new
    @employee = Employee.new
  end

  def detail
    isFirst = params[:isFirst]

    if isFirst
    end

    #if first employee redirect_to index with employeeId info
  end

  def create
    firstName = params[:employee][:firstName]
    lastName = params[:employee][:lastName]
    password = params[:employee][:password]
    verifyPassword = params[:employee][:verify_password]
    classification = params[:employee][:classification]

    if password != verifyPassword
      flash[:error] = "Passwords do not match"
      redirect_to new_employee_path
      return
    end

    employee = Employee.new(firstName: firstName, lastName: lastName,
                            password: password)

    puts "Classification: " + "#{classification}"
    classificationHash = {
      "general_manager" => :generalManager,
      "shift_manager" => :shiftManager,
      "cashier" => :cashier,
    }

    temp = classificationHash[classification]
    if temp.nil?
      puts "IS NIL"
      flash[:error] = "Please pick a classification"
      redirect_to new_employee_path
      return
    end

    employee.classification = temp

    if employee.save
      puts "Is First: #{params[:isFirst]}"
      if params[:employee][:isFirst] == "true"
        redirect_to employees_path(employeeId: employee.employeeId)
      else
        flash[:notice] = "ID is: #{employee.employeeId}"
        redirect_to main_menu_index_path
      end
    else
      flash[:error] = "Employee did not save, please try again"
      redirect_to new_employee_path
    end
  end
end
