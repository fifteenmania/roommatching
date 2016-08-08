class HomeController < ApplicationController
    def index
        
    end
    
    def userinfo
        render :json => {is_login: !current_user.nil?, 
                        user: current_user.as_json(only: [:image, :email, :stage])}
    end
end
