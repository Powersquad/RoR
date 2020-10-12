class ProductListingController < ApplicationController
    def index
        @products = Product.all
    end
end
