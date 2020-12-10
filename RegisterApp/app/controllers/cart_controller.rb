class CartController < ApplicationController
  before_action :checkEmployee

  def index
    employee = Employee.find_by(employeeId: session[:employeeId])
    cart = employee.cart
    @cartHash = cart.getCart
    
    
  end

  

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

  def subItem
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
      flash[:notice] = "No product"
      render plain: "No product"
      return

    else
      if amount!=0
        cartHash[lookupCode] = amount - 1
      end
    end
    save = cart.setCart(cartHash)
    if save
      flash[:notice] = "Deleted 1 #{lookupCode} item"
      render plain: "Deleted 1 #{lookupCode} item"
    else
      flash[:error] = "Couldn't delete 1 #{lookupCode} item"
      render plain: "Couldn't delete 1 #{lookupCode} item"
    end
  end

  def deleteItem
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
    save = false
    if amount.nil?
      flash[:notice] = "No product"
      render plain: "No product"
      return
    else
      hash = cartHash.reject { |k, v| k == lookupCode }
      save = cart.setCart(hash)
    end
    if save
      flash[:notice] = "Deleted #{lookupCode} item"
      render plain: "Deleted #{lookupCode} item"
    else
      flash[:error] = "Couldn't delete #{lookupCode} item"
      render plain: "Couldn't delete #{lookupCode} item"
    end
  end

  def deleteAllItems
    carts.each do |cart|
      hash = cart.getCart()
      hash = hash.reject { |k, v| k == lookupCode }
      cart.setCart(hash)
    end
  end

  def checkEmployee
    if Employee.find_by(employeeId: session[:employeeId]).nil?
      render plain: "Can't find employeeId"
      return
    end
  end
end
