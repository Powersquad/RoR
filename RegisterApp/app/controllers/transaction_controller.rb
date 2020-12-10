class TransactionController < ApplicationController
  def index
  end

  def show
  end

  def create
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
end
