class MainMenuController < ApplicationController
    skip_before_action :authenticate_employee!, only: [:index]

    def index

         
    end
end