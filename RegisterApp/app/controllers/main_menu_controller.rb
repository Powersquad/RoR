class MainMenuController < ApplicationController
    skip_before_action :authenticate_employee!, only: [:test]

    def test
        product = Product.new(lookupCode: "zxcbsa")
        product.save
        render json: product
    end

    def index

    end
end