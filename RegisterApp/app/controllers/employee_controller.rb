class EmployeeController < ApplicationController
    #skip_before_action :authenticate_employee!, only: [:create]
    skip_before_action :verify_authenticity_token

    def index

    end
    
    def create
        puts "creating new employee"
        classification = params[:classification]
        firstName = params[:firstName]
        lastName = params[:lastName]
        password = params[:password]
        password2 = params[:password2]
        @error = ""
        if password.blank? || password2.blank?
            @error = "password blank"
        elsif firstName.blank?
            @error = "First Name is blank"
        elsif lastName.blank?
            @error = "Last Name is blank"
        elsif !(classification == "general_manager" || classification == "shift_manager" || classifciation == "cashier")
            puts classification
            @error = "classifcation is not any of the following: general_manager, shift_manager, cashier"
        elsif password != password2
            @error = "password are not the same"
        else 
            number = 0
            if classification == "shift_manager"
                number = 1
            elsif classification == "cashier"
                number = 2
            end
            @employee = Employee.new(email: 0, password: password, 
                firstName: firstName, lastName: lastName, manager_id: current_employee.email)
            @employee.classification = number
            puts @employee.classification
            if @employee.save
                @error = "Employee is save with id: " + @employee.email

            else 
                @error = "Something went wrong. Employee didn't save"
                
            end
        end
        render "index"
    end
end