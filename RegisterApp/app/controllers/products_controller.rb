class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def search
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
    render "index.html.erb"
  end

  def show
    @product = Product.find_by(lookupCode: params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    id = params[:product][:id]
    count = params[:product][:count]
    product = Product.new(lookupCode: id, count: count)

    if product.save
      flash[:notice] = "Product created"
      redirect_to edit_product_path(id)
    else
      flash[:error] = "Product did not save, please try again"
      redirect_to new_product_path
    end
  end

  def edit
    puts params[:i]
    @product = Product.find_by(lookupCode: params[:id])
    puts @product.lookupCode
    puts @product.count
  end

  def update
    lookupCode = params[:product][:lookupCode]
    count = params[:product][:count]
    product = Product.find_by(lookupCode: lookupCode)
    product.count = count

    if product.save
      flash[:notice] = "Product was successfully saved"
    else
      flash[:error] = "Product was not saved, please try again"
    end
    redirect_to edit_product_path(lookupCode)
  end

  def destroy
    lookupCode = params[:id]

    product = Product.find_by(lookupCode: lookupCode)

    if product.destroy
      flash[:notice] = "Product was deleted"
      carts = Cart.all
      carts.each do |cart|
        byebug
        hash = cart.getCart()
        hash = hash.reject { |k, v| k == lookupCode }
        cart.setCart(hash)
      end
    else
      flash[:error] = "Product was not deleted, please try again"
    end
    redirect_to products_path
  end
end
