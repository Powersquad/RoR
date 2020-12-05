class ProductsController < ApplicationController
  def index
    @products = Product.all
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
      flash[:noitce] = "Product created"
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
    else
      flash[:error] = "Product was not deleted, please try again"
    end
    redirect_to products_path
  end
end
