class MainMenuController < ApplicationController
  def index
    @employee = Employee.find_by(employeeId: session[:employeeId])
  end
end
