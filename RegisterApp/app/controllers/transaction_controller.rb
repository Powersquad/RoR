class TransactionController < ApplicationController
  before_action :checkEmployee
  def index
    employee = Employee.find_by(employeeId: session[:employeeId])
    @transactions = employee.transactions
  end

  def show
    employee = Employee.find_by(employeeId: session[:employeeId])
    @transaction = employee.transactions.find_by(id: params[:id])
    
  end

  def create
    employee = Employee.find_by(employeeId: session[:employeeId])
    cart = employee.cart
    newTrans = Transaction.new
    newTrans.employee = employee
    save = newTrans.setTrans(cart.getCart)
    if save
      flash[:notice] = "Product created"
      redirect_to transaction_index_path
      cart.setCart({})
    else
      flash[:error] = "Product did not save, please try again"
      redirect_to cart_index_path
    end
    
  end

  def destroy
    transaction_id = params[:id]
    employee = Employee.find_by(employeeId: session[:employeeId])
    transaction = employee.transactions.find_by(id: transaction_id)

    if transaction.destroy
      flash[:notice] = "Transaction was deleted"
    else
      flash[:error] = "Transaction was not deleted, please try again"
    end
    redirect_to transaction_path
  
  end

  def productBrowsing
    @products = Product.all
  end

  def productSearch
    searchCriteria = params[:searchCriteria]
    allProducts = Product.all
    @products = []

    if searchCriteria.nil?
      render plain: "Search Criteria is nil"
      return
    end
    if allProducts.empty?
      return
    end

    allProducts.each do |product|
      match = true
      lookupCode = product.lookupCode
      count = 0
      searchCriteria.split("").each { |c|
        lookupCodeCharacter = lookupCode[count]
        if lookupCodeCharacter.nil?
          match = false
        end
        match = false unless c == lookupCodeCharacter
        count = count + 1
      }
      if match
        @products.append(product)
      end
      puts "Criteria: #{searchCriteria}"
      puts "Product LookupCode: #{lookupCode}"
      puts "Match: #{match}"
    end
    render "item_browsing.html.erb"
  end

  def checkEmployee
    if Employee.find_by(employeeId: session[:employeeId]).nil?
      render plain: "Can't find employeeId"
      return
    end
  end

end
