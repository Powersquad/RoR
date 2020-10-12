class ProductDetailController < ApplicationController
    def index

    end

    def new
        lookupCode = params[:lookupCode]
        count = params[:lookupCode]

        if !lookupCode.nil?
            if count.nil?
                product = Product.new(lookupCode: lookupCode)
                product.save
            else
                product = Product.new(lookupCode: lookupCode, count: count)
                product.save
            end
        end

        if product.nil?
            puts "Product didn't save correctly"
        else
            puts "Saved"
        end
    end
end
