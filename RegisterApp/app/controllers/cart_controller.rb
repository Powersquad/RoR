class CartController < ApplicationController
  before_action :checkEmployee

  def index
    employee = Employee.find_by(employeeId: session[:employeeId])
    cart = employee.cart
    @cartHash = cart.getCart
  end

  def addItem
    lookupCode = params[:lookupCode]
    action = params[:original]
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
      if action == "cartAdd"
        flash[:notice] = "Added 1 product for #{lookupCode}"
        redirect_to cart_index_path
      elsif action == "productAdd"
        flash[:notice] = "Added #{lookupCode} to cart"
        redirect_to product_browsing_transaction_index_path
      else
        flash[:error] = "Wrong action for #{lookupCode} item"
        redirect_to main_menu_index_path
      end
    else
      flash[:error] = "Couldn't add #{lookupCode} item"
      redirect_to cart_index_path
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
      if amount == 1
        cartHash = cartHash.reject { |k, v| k == lookupCode }
      else
        cartHash[lookupCode] = amount - 1
      end
    end
    save = cart.setCart(cartHash)
    if save
      flash[:notice] = "Sub 1 product for #{lookupCode}"
      redirect_to cart_index_path
    else
      flash[:error] = "Couldn't delete 1 #{lookupCode} item"
      redirect_to cart_index_path
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
      flash[:notice] = "Removed product for #{lookupCode}"
      redirect_to cart_index_path
    else
      flash[:error] = "Couldn't delete #{lookupCode} item"
      redirect_to cart_index_path
    end
  end

  def deleteAllItems
    employee = Employee.find_by(employeeId: session[:employeeId])
    cart = employee.cart
    save = cart.setCart({})

    if save
      flash[:notice] = "Cleared Cart"
    else
      flash[:error] = "Could not clear Cart"
    end
    redirect_to product_browsing_transaction_index_path
  end

  def checkEmployee
    if Employee.find_by(employeeId: session[:employeeId]).nil?
      render plain: "Can't find employeeId"
      return
    end
  end
end
