class TransactionController < ApplicationController
  def index
  end

  def show
  end

  def create
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