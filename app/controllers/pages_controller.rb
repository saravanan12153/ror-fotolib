class PagesController < ApplicationController
    def home
        if current_user
            redirect_to pics_path
        end
    end

    def about
    end
end
