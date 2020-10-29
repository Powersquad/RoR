class SessionsController < ApplicationController
  def create
    employee = Employee.find_by(employeeId: params[:employeeId])
    
        if employee && employee.authenticate(params[:password]) 
            session[:employeeId] = employee.employeeId
            flash[:notice] = "Logged in successfully"
            redirect_to main_menu_index_path
        else
            flash[:error] = "There was something wrong. Can't sign in, please try again"
            redirect_to employees_path
        end
  end
  
  def destroy
    session[:employeeId] = nil
    flash[:noitce] = "Logged Out"
    redirect_to root_path
  end
end
