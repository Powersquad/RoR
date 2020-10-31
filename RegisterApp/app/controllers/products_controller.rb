class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(lookupCode: params[:id])
  end

  def new
  end

  def create
    id = params[:product][:id]
    count = params[:product][:count]
    product = Products.new(lookupCode: id, count: count)

    if product.save
      flash[:noitce] = "Product created"
      redirect_to edit_product_path(id)
    else
      flash[:error] = "Product did not save, please try again"
      redirect_to new_product_path
    end
  end

  def edit
  end

  def update
    id = params[:product][:id]
    count = params[:product][:count]
    product = Product.find(lookupCode: id)
    product.count = count

    if product.save
      flash[:notice] = "Product was successfully saved"
    else
      flash[:error] = "Product was not saved, please try again"
    end
    redirect_to edit_product_path(id)
  end

  def destroy
    id = params[:product][:id]
    product = Product.find(lookupCode: id)

    if product.destroy
      flash[:notice] = "Product was deleted"
    else
      flash[:error] = "Product was not deleted, please try again"
    end
    redirect_to edit_product_path(id)
  end
end
