class CartController < ApplicationController
  before_action :checkEmployee

  def addItem
    lookupCode = params[:lookupCode]

    if lookupCode.nil?
      flash[:notice] = "No lookupCode"
      render plain: "No lookupCode"
      return
    end

    employee = Employee.find_by(employeeId: session[:employeeId])

    cart = employee.cart
    cartHash = cart.getCart
    amount = cartHash[lookupCode]
    if amount.nil?
      cartHash[lookupCode] = 1
    else
      cartHash[lookupCode] = amount + 1
    end
    save = cart.setCart(cartHash)

    if save
      flash[:notice] = "Added #{lookupCode} item"
      render plain: "Added #{lookupCode} item"
    else
      flash[:error] = "Couldn't add #{lookupCode} item"
      render plain: "Couldn't add #{lookupCode} item"
    end
  end

  def checkEmployee
    if Employee.find_by(employeeId: session[:employeeId]).nil?
      render plain: "Can't find employeeId"
      return
    end
  end
end
